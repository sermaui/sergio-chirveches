Add-Type -AssemblyName System.Drawing
$in='C:\Users\MAUI\Desktop\master D\img\maui-photo.jpg'
$out='C:\Users\MAUI\Desktop\master D\img\maui-photo-up.jpg'
$img=[System.Drawing.Image]::FromFile($in)
$w=1200
$h=[int]($img.Height * $w / $img.Width)
$bmp = New-Object System.Drawing.Bitmap $w,$h
$g=[System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode=[System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.DrawImage($img,0,0,$w,$h)
$enc=[System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object {$_.MimeType -eq 'image/jpeg'}
$ep=New-Object System.Drawing.Imaging.EncoderParameters 1
$ep.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality,90)
$bmp.Save($out,$enc,$ep)
$g.Dispose()
$bmp.Dispose()
$img.Dispose()
Write-Host "Saved $out"
