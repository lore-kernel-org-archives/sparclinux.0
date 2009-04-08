From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 08 Apr 2009 21:45:51 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090408214551.GB10366@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> Ok, here's the log. It hangs in the middle of an output.

> [   63.033414] calling  i2c_init+0x0/0x70 @ 1
> [   63.033463] initcall i2c_init+0x0/0x70 returned 0 after 0 usecs
> [   63.033468] calling  cpu_type_probe+0x0/0x274 @ 1
> [   63.033476] initcall cpu_type_probe+0x0/0x274 returned 0 after 0 usecs
> [   63.033482] calling  pcr_arch_init+0x0/0x14c @ 1
> [   

So it looks like it hangs in pcr_arch_init().
Try to make that function a noop and see if you get further.

The easiet is to comment out the line:

    arch_initcall(pcr_arch_init);

In the file: arch/sparc/kernel/pcr.c

And see if you get further.

	Sam
