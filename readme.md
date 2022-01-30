<h1>Johns Police Menu</h1>

<h4>Created by JohnL#6869 (Discord)</h4>

<h4>Features</h4>

<ul>
    <li>Customizable Loadouts</li>
    <li>Actions</li>
        <li>Cuff/Uncuff</li>
        <li>Drag/Undrag</li>
        <li>Place in Vehicle</li>
        <li>Remove from Vehicle</li>
        <li>Remove Weapons</li>
        <li>Place/Remove Spikestrips</li>
    <li>Commands</li>
        <li>/hu (Puts hands up)</li>
        <li>/handsup (Puts hands up)</li>
        <li>/surrender (Kneels on ground to give self up)</li>
        <li>/kneel (Kneels on ground to give self up)</li>
        <li>/k (Kneels on ground to give self up)</li>
        <li>/openpm (Opens Police Menu)</li>
    <li>Controls</li>
        <li>F9 (Opens Police Menu)</li>
        <li>Players can change the open menu function in their keybind settings.</li>
</ul>


<h4>Modifying Config</h4>
<ul>
<li>If you would like to add more weapons, simply add the name to the weapons>spawn portion. You can find a full list of weapons in the weapons.lua file.</li>
<li>If you would like to add more attachments, simply add the name of the weapon.attachment. For example: WEAPON_PISTOL.suppressor. You can find a full list of weapon attachments in the weapons.lua file.</li>
<li>The permission system is very simple. Add anyone you would like to have access to the menu to the Config.Accesslist. You can also lock certain loadouts to players by adding them to the perms list. If you only want certain individuals to have access to a loadout be sure to change the access variable to false then add them to the perms list.</li>
<li>Note: I tried my best to make it very straight forward for people that are new to development or have no idea what they are looking at. If you have questions don't be afraid to reach out on discord!</li>
</ul>

<h4>Installation</h4>

<ol>
  <li>Download dpemotes <a href="https://github.com/andristum/dpemotes/releases">here</a>. This is a dependency, you need this for the Police Menu.</li>
  <li>Download johnspolicemenu <a href="https://github.com/chickenlord01/johnspolicemenu">here</a>.</li>
  <li>Extract the folders and upload it to your FiveM server.</li>
  <li>Add the resources to your server.cfg file. (dpemotes before johnspolicemenu)</li>
</ol>

<h4>Credits</h4>

<ul>
  <li>Thanks to BritishBrotherhood for the spikescripts script: <a href="https://forum.cfx.re/t/release-spike-strips-code-updated-09-03-2019/177461">Link</a></li>
  <li>Thanks to Warxander for the menu api: <a href="https://forum.cfx.re/t/release-warmenu-lua-menu-framework/41249">Link</a></li>
  <li>If any bug/issue is found please submit it on the github page.</li>
</ul>