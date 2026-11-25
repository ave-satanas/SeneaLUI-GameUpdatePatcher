using System.Collections.Generic;
using System.Linq;
using BepInEx.Logging;
using Mono.Cecil;
using Mono.Cecil.Cil;

namespace SeneaLUI.GameUpdatePatcher
{
    // SeneaL UI 1.2.8 was built against game code that later Valheim updates renamed. A BepInEx preloader patcher
    // runs before the game's code is loaded, so it can put an old name back, in memory only, for SeneaL UI to find.
    // Each fix does nothing when the game does not have the change it is for.
    public static class Patcher
    {
        public static IEnumerable<string> TargetDLLs { get; } = new[] { "assembly_valheim.dll" };

        public static void Patch(AssemblyDefinition assembly)
        {
            var log = Logger.CreateLogSource("SeneaL UI Game Update Patcher");
            foreach (string line in Apply(assembly.MainModule)) log.LogInfo(line);
        }

        // Kept apart from Patch so it can be run on a copy of the game's DLL outside the game.
        public static List<string> Apply(ModuleDefinition game)
        {
            var done = new List<string>();
            done.Add(ConnectPanelRoot(game));
            return done;
        }

        // Valheim 1.0.30 renamed ConnectPanel.m_root (the F2 panel) to m_connectRoot. SeneaL UI reads m_root on every
        // frame of the menu, so the pause menu never opened. The old field comes back beside the new one and is
        // given the same object when the panel starts.
        private static string ConnectPanelRoot(ModuleDefinition game)
        {
            const string what = "ConnectPanel.m_root: ";
            var panel = game.GetType("ConnectPanel");
            if (panel == null) return what + "nothing to do (no ConnectPanel)";
            if (panel.Fields.Any(f => f.Name == "m_root")) return what + "nothing to do (the game has it)";
            var now = panel.Fields.FirstOrDefault(f => f.Name == "m_connectRoot");
            var start = panel.Methods.FirstOrDefault(m => m.Name == "Start" && m.HasBody && !m.IsStatic && m.Parameters.Count == 0);
            if (now == null || start == null) return what + "not fixed (the game has no m_connectRoot or no Start: a newer change)";
            // Not serialized: Unity must not look for it in the panel's saved data.
            var old = new FieldDefinition("m_root", FieldAttributes.Public | FieldAttributes.NotSerialized, now.FieldType);
            panel.Fields.Add(old);
            var il = start.Body.GetILProcessor();
            var first = start.Body.Instructions[0];
            il.InsertBefore(first, il.Create(OpCodes.Ldarg_0));
            il.InsertBefore(first, il.Create(OpCodes.Ldarg_0));
            il.InsertBefore(first, il.Create(OpCodes.Ldfld, now));
            il.InsertBefore(first, il.Create(OpCodes.Stfld, old));
            return what + "put back (it follows m_connectRoot)";
        }
    }
}
