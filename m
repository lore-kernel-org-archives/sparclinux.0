From: Mitch Bradley <wmb@firmworks.com>
Date: Wed, 07 Oct 2009 19:30:47 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <4ACCEC67.9070106@firmworks.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>	<fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com>	<646765f40910062218s19d540f9q14c9086bedd1d9da@mail.gmail.com> <20091007135243.GC21646@anhedonia>
In-Reply-To: <20091007135243.GC21646@anhedonia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Creasey <sammy-4OGMY2YDKIVeoWH0uzbU5w@public.gmane.org>
Cc: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

>
> Sun3 doesn't have OF

When I was first developing Open Boot for the SPARCstation-1, I was also 
simultaneously trying to do it for a Sun-3 system that was being built 
at the same time.

It proved to be too much to do both jobs at the same time, especially in 
light of all the hardware debugging that is part of a new system 
bringup.  So I gave up on Sun 3 and just focused on SS-1.

That particular Sun-3 machine never sold very well, while the SS-1 was 
very popular.  That was Sun's last 680x0 machine.

Personally, I think that continuing to support Sun-3 in Linux is not 
useful in a practical sense.  To the extent that supporting 
long-obsolete platforms and devices makes the job harder for current 
systems, it is actually harmful.  Portability and generality is good in 
some theoretical "rightness" sense, but there are practical limits.  
Code can become so heavily layered that approaching it requires a huge 
commitment of effort to learn all the artificial layers.  Sometimes you 
have to prune the dead branches so the living ones can get light and air.

Taking this one step further, I don't see any real good reason to 
continue supporting Sun4 going forward.  I got rid of my Sun4 systems 
long ago because it was just too hard to keep them working - after 
having used them long after most people had moved on.  Dropping Sun3 and 
Sun4 eliminates all vestiges of the sunmon interface and also allows 
dropping support for OBP version 1, which only shipped on SS1-class 
machines - the first machines in the Sun4c subclass. 

