From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 08 Apr 2009 20:59:22 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090408205922.GB9970@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 08, 2009 at 10:07:11PM +0200, seb@frankengul.org wrote:
> Hi,
> I'm not able to boot 2.6.29.1 kernel compiled for V240.
> Kernel just hang.
> I'm attaching the boot.log and the config file used.
> The 2.6.28 works ok.
> Is there something missing.
> It's the third time I'm trying to build the kernel and none did boot.
> 2.6.29 hanged when switch to console.
> 2.6.29.1 goes further but not by much.
> 
> Seb

I think it is a know problem.
See http://lkml.org/lkml/2009/4/8/255

	Sam
