var vids = document.getElementsByTagName('video');

for (var i = 0; i < vids.length; i++)
{
	var aVid = vids[i];
	aVid.autoplay = false;
}