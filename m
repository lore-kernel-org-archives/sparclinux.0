From: David Miller <davem@davemloft.net>
Date: Tue, 20 Jan 2009 06:26:22 +0000
Subject: Re: kernel crashes on Sun Fire 480R with cassini network driver
Message-Id: <20090119.222622.111613313.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Thu, 18 Dec 2008 15:12:20 +0100

> On Wed, Dec 17, 2008 at 07:44:36PM -0800, David Miller wrote:
> > Could you please get one of those JTAG SCAN dumps after
> > the crash, and provide the exact kernel image and System.map
> > file for me to download somewhere?
> 
> I reproduced a crash with the current debian 2.6.24-etchnhalf.1-sparc64-smp
> kernel, and the relevant files from /boot are on:
> 
> http://www.iwr.uni-heidelberg.de/ftp/linux/sparc-boot/
> 
> The initrd is also included, console with the JTAG SCAN
> output is in crash.console.
> 
> Please tell me if you need anything else.
> Thanks for looking at it.

I have looked at this for a few days, and there are no real good clues
in there unfortunately.

But don't fear, let's get 2.6.27.x booting properly and then try to
get back to this bug.
