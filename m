From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 01 Aug 2004 19:57:41 +0000
Subject: Re: Question about recent copy_user.S change
Message-Id: <20040801195741.GY2334@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040801192158.GB7321@artsapartment.org>
In-Reply-To: <20040801192158.GB7321@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Aug 01, 2004 at 02:21:58PM -0500, Art Haas wrote:
> The 1.3->1.4 changes to the arch/sparc/lib/copy_user.S file added
> parenthesis to a number of macros within that file. The BK changlog
> associated with this change indicate the change was to make the
> file work with gcc-3.3.
> When looking at the changes made, I see that similar macros exist in
> memcpy.S as well, so would a patch adding parens to that file be
> worthwhile? Also, just what was the problem with gcc-3.3 that was
> resolved by adding the parenthesis? Macro mis-expansion I'm guessing.
> On a side note, the 2.6.8-rc2 kernel my SS20 has been using for the last
> several days has been, by far, the stablest 2.6 kernel run on that
> machine. I hate to write this for fear of jinxing things, but previous
> 2.6 kernels would boot and run for a while, and then the machine would
> get SCSI errors. Typically these errors occurred when doing something
> like 'cvs update', or compiling some software on the machine. The
> current kernel has had numerous cvs operations performed without
> problem, as well as several BitKeeper 'pull' operations and various
> builds without incident. Kudos to the kernel developers.

Could you post some system log information about the SCSI errors?

Thanks.


-- wli
