From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 19 May 2020 16:29:05 +0000
Subject: Re: [PATCH V3 07/15] arch/kunmap_atomic: Consolidate duplicate code
Message-Id: <20200519162904.GA3356843@iweiny-DESK2.sc.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200507150004.1423069-1-ira.weiny@intel.com>
 <20200507150004.1423069-8-ira.weiny@intel.com>
 <20200516223306.GA161252@roeck-us.net>
 <20200518034938.GA3023182@iweiny-DESK2.sc.intel.com>
 <20200518042932.GA59205@roeck-us.net>
 <20200519000352.GF3025231@iweiny-DESK2.sc.intel.com>
 <47757f51-15f2-3abe-9035-abdb3ba5816e@roeck-us.net>
In-Reply-To: <47757f51-15f2-3abe-9035-abdb3ba5816e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Mon, May 18, 2020 at 07:50:36PM -0700, Guenter Roeck wrote:
> Hi Ira,
> 
> On 5/18/20 5:03 PM, Ira Weiny wrote:
> > On Sun, May 17, 2020 at 09:29:32PM -0700, Guenter Roeck wrote:
> >> On Sun, May 17, 2020 at 08:49:39PM -0700, Ira Weiny wrote:
> >>> On Sat, May 16, 2020 at 03:33:06PM -0700, Guenter Roeck wrote:
> >>>> On Thu, May 07, 2020 at 07:59:55AM -0700, ira.weiny@intel.com wrote:
> >>>>> From: Ira Weiny <ira.weiny@intel.com>
> >>>>>
> >>>

Sorry for the delay I missed this email last night...  I blame outlook...  ;-)

...

> >>> Do you have a kernel config?  Specifically is CONFIG_HIGHMEM set?
> >>>
> >> See below. Yes, CONFIG_HIGHMEM is set.
> >>
> >> The scripts used to build and boot the image are at:
> >>
> >> https://github.com/groeck/linux-build-test/tree/master/rootfs/microblazeel
> > 
> > Despite finding the obvious error earlier today I've still been trying to get
> > this to work.
> > 
> > I had to make some slight modifications to use the 0-day cross compile build
> > and my local qemu build.  But those were pretty minor modifications.  I'm
> > running on x86_64 host.
> > 
> > With those slight mods to the scripts I get the following error even without my
> > patch set on 5.7-rc4.  I have 1 cpu pegged at 100% while it is running...  Is
> > there anything I can do to get more debug output?  Perhaps I just need to let
> > it run longer?
> > 
> 
> I don't think so. Try running it with "-d" parameter (run-qemu-microblazeel.sh
> -d petalogix-s3adsp1800); that gives you the qemu command line. Once it says
> "running", abort the script and execute qemu directly.

FYI Minor nit...  a simple copy/paste failed...  that print of the cmd line
did not include quotes around the -append text:

09:06:03 > /home/iweiny/dev/qemu/microblazeel-softmmu/qemu-system-microblazeel
   -M petalogix-s3adsp1800 -m 256 -kernel arch/microblaze/boot/linux.bin
   -no-reboot -initrd /tmp/buildbot-cache/microblazeel/rootfs.cpio -append
   panic=-1 slub_debug=FZPUA rdinit=/sbin/init console=ttyUL0,115200 -monitor
   none -serial stdio -nographic

qemu-system-microblazeel: slub_debug=FZPUA: Could not open 'slub_debug=FZPUA': No such file or directory

> Oh, and please update
> the repository; turns out I didn't push for a while and made a number of
> changes.

Cool beans...  I've updated.

> 
> My compiler was compiled with buildroot (a long time ago). I don't recall if
> it needed something special in the configuration, unfortunately.

AFAICT the compile is working...  It is running from the command line now...  I
expected it to be slow so I have also increased the timeouts last night.  So
far it still fails.  I did notice that there is a new 'R' in the wait output.

<quote>
.........................R......................... failed (silent)
------------
qemu log:
qemu-system-microblazeel: terminating on signal 15 from pid 3357146 (/bin/bash)
</quote>

I was hoping that meant it found qemu 'running' but looks like that was just a
retry...  :-(

Last night I increased some of the timeouts I could find.

<quote>
 LOOPTIME=5     # Wait time before checking status
 -MAXTIME0    # Maximum wait time for qemu session to complete
 -MAXSTIME`    # Maximum wait time for qemu session to generate output
 +#MAXTIME0   # Maximum wait time for qemu session to complete
 +#MAXSTIME`   # Maximum wait time for qemu session to generate output
 +MAXTIME00    # Maximum wait time for qemu session to complete
 +MAXSTIME0   # Maximum wait time for qemu session to generate output
</quote>

But thanks to the qemu command line hint I can see these were not nearly
enough...  (It has been running for > 20 minutes...  and I'm not getting
output...)  Or I've done something really wrong.  Shouldn't qemu be at least
showing something on the terminal by now?  I normally run qemu with different
display options (and my qemu foo is weak) so I'm not sure what I should be
seeing with this command line.

09:06:28 > /home/iweiny/dev/qemu/microblazeel-softmmu/qemu-system-microblazeel
  -M petalogix-s3adsp1800 -m 256 -kernel arch/microblaze/boot/linux.bin
  -no-reboot -initrd /tmp/buildbot-cache/microblazeel/rootfs.cpio -append
  "panic=-1 slub_debug=FZPUA rdinit=/sbin/init console=ttyUL0,115200" -monitor
  none -serial stdio -nographic

Maybe I just have too slow of a machine...  :-/

My qemu was built back in March.  I'm updating that now...

Sorry for being so dense...
Ira
