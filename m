From: Frans van Berckel <fberckel@xs4all.nl>
Date: Fri, 24 Apr 2009 19:00:23 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <1240599623.3532.20.camel@deblnxsrv254.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

If I am well informed there's a respiratory for the Ubuntu next, called
Jaunty. As well the next+1 Ubuntu called Karmic online available now.

http://ports.ubuntu.com/dists/jaunty/

deb http://ports.ubuntu.com/ubuntu-ports/ jaunty main restricted
deb http://ports.ubuntu.com/ubuntu-ports/ jaunty universe multiverse

http://ports.ubuntu.com/dists/karmic/

deb http://ports.ubuntu.com/ubuntu-ports/ karmic main restricted
deb http://ports.ubuntu.com/ubuntu-ports/ karmic universe multiverse

Thanks,


Frans van Berckel

On Fri, 2009-04-24 at 08:44 -0700, David Miller wrote:
> I notice in your kernel logs that you're using an Ubuntu gcc version
> 4.3.x.
> 
> How in the world is that possible?
> 
> Ubuntu sparc support stopped after Ubuntu version 7.10 and that
> shipped with gcc-4.1.x as the default compiler.  That's what I use
> for most of my testing FWIW.  On my debian boxes I use the
> default gcc-4.3.2 based compiler.
> 
> If you're using a custom built compiler, we're going to have to do
> some tests to rule that out as the cause of your problems I think.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

