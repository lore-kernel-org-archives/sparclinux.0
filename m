From: Jim Faulkner <jfaulkne@ccs.neu.edu>
Date: Fri, 02 Sep 2011 01:10:24 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110902011023.GA6634@alumni-linux.ccs.neu.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 31, 2011 at 03:59:56PM -0400, David Miller wrote:
> 
> There is a non-trivial problem with the device tree reported by your
> firmware, several PCI device nodes are reported multiple times.
> 
> If you'll look 'isa' appears twice, and so does 'pmu'.
> 
> This is a very serious issue.
> 
> And that's what is causing all of these boot failures.
> 
> I have two theories, either the Tulip card makes the firmware corrupt
> the device tree like this.  Or, alternatively, there is some bug in
> the version of OBP installed on this machine.
> 
> This really isn't a kernel bug.  And if it worked in the past, it worked
> entirely by accident.

Thanks so much for the info!  I finally have 3.0.3 booting normally.
First thing I did was update to the latest firmware, 4.17.1, which can
be found at http://ftp.sunet.se (the readme is here:
http://ftp.sunet.se/pub/security/vendor/sun/patches/all_unsigned/119235-01.README).
This was a bit of a chore because neither the SILO nor the Solaris
loader wanted to boot the firmware update.  I had to setup a tftp
netboot server in order to patch the firmware.

But, that didn't fix the problem.

Next, I yanked the tulip card.  That didn't fix the problem either.

Finally, I reset nvram by typing this at openprom's "ok" prompt:
set-defaults 

A reset-all and... it works!  I can boot 3.0.3!

Thanks for your patience in helping me get this machine going w/ Linux.
I'll add this info to the bugzilla report and close the bug.

thanks again,
Jim Faulkner

