From: David Miller <davem@davemloft.net>
Date: Wed, 31 Aug 2011 19:59:56 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110831.155956.1439093033980491050.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Faulkner <jfaulkne@ccs.neu.edu>
Date: Tue, 30 Aug 2011 20:47:16 -0400

> On Tue, Aug 30, 2011 at 07:26:24PM -0400, David Miller wrote:
>> 
>> Can you give us "/usr/sbin/prtconf -pv" output from a working boot
>> so we can add it to our collection?  Thanks.
>> 
>> Try turning on the ofpci_verbose tracing facility by passing
>> 'ofpci_debug=1' on the kernel command line.
>> 
> 
> OK, I've attached the output of prtconf -pv.  AFAIK the only things in
> the box that didn't ship from the factory are a tulip ethernet card and
> the hard drives.  I don't have a reason to believe that they are causing
> the problem.

There is a non-trivial problem with the device tree reported by your
firmware, several PCI device nodes are reported multiple times.

If you'll look 'isa' appears twice, and so does 'pmu'.

This is a very serious issue.

And that's what is causing all of these boot failures.

I have two theories, either the Tulip card makes the firmware corrupt
the device tree like this.  Or, alternatively, there is some bug in
the version of OBP installed on this machine.

This really isn't a kernel bug.  And if it worked in the past, it worked
entirely by accident.
