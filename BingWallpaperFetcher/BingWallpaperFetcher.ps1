$x = Split-Path -Parent $MyInvocation.MyCommand.Definition
cd $x
$url = "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&ensearch=1"
$data = Invoke-WebRequest $url
$decode = ConvertFrom-Json($data)
$temp = $decode.images.Get(0)
$urlsplit = -Join("https://www.bing.com",$temp.url)
Invoke-WebRequest $urlsplit -OutFile ("wallpaper.jpg")

function Set-Wallpaper
{
    param
    (
        [Parameter(Mandatory=$true)]
        $Path,

        [ValidateSet('Center', 'Stretch')]
        $Style = 'Center'
    )

    Add-Type @"
        using System;
        using System.Runtime.InteropServices;
        using Microsoft.Win32;
        namespace Wallpaper
        {
            public enum Style : int { Center, Stretch }
            public class Setter
            {
                public const int SetDesktopWallpaper = 20;
                public const int UpdateIniFile = 0x01;
                public const int SendWinIniChange = 0x02;
                [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
                private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);
                public static void SetWallpaper ( string path, Wallpaper.Style style )
                {
                    SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );
                    RegistryKey key = Registry.CurrentUser.OpenSubKey("Control Panel\\Desktop", true);
                    key.Close();
                }
            }
        }
"@
    
    [Wallpaper.Setter]::SetWallpaper( $Path, $Style )
} 

$file = $x + "\wallpaper.jpg"
Set-Wallpaper -Path $file
