From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sun, 26 Nov 2017 20:52:16 +0000
Subject: Re: Silo on RAID 1
Message-Id: <1511729536.1834.37.camel@xs4all.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <1511689792.4483.9.camel@xs4all.nl>
In-Reply-To: <1511689792.4483.9.camel@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Chase,

On Sun, 2017-11-26 at 15:12 -0500, chase rayfield wrote:

> Shouldn't your partition index for silo be 1 if you are following
> this guide? Silo counts partitions 1-n not 0-n like grub etc...
> 
> https://www.unix.com/linux/141253-sparc-linux-raid1-silo.html

Are you sure? Because the Silo readme from David's tree calls ...

"Note that numbers start at 0, rather than Linux's convention of
starting at 1, so sd(0,3,1) is /dev/sda2."

Please checkout docs/README.

https://git.kernel.org/pub/scm/linux/kernel/git/davem/silo.git/

Thanks for supporting,


Frans van Berckel
