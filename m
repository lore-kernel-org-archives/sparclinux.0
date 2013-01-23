From: Jean-Michel Bergeron <niceguy12345678@hotmail.fr>
Date: Wed, 23 Jan 2013 10:17:50 +0000
Subject: XVR-1200 Framebuffer support in Xorg
Message-Id: <COL116-W52A5C80002C97C99FED1F3D8150@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi,

I use a Sun Blade 2500 equipped with an XVR-1200 framebuffer (video card). In solaris there's no problems at all, but when I try to start Xorg in Linux Debian I see something but the picture is all blurry, so basically it's practically impossible to use Xorg with that videocard... I'm an intermediate-level user but I managed to find that the card seem to use the FBDEV Xorg driver and that it seem to get detected as an XVR-500, my guess is that Xorg doesn't support the XVR-1200 yet...

I asked this question in the Xorg #xorg-devel Freenode IRC channel and they suggested I ask on this list instead since they apparently don't develop drivers themselves... I would hope that if it's not the right place to ask somebody would guide me in the right direction...

If I provide the development team with one expensive XVR-1200 Sun video card, would it be possible to update the FBDEV driver so it would support that videocard? Currently we see something on the screen except the picture is all fuzzy and blurry, so in my opinion it should be very easy to fix...

Thanks in advance

Jean-Michel Bergeron
 		 	   		  