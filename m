From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 21 Oct 2004 00:47:33 +0000
Subject: Re: Help Wanted: Floppy and CG3 Problems using Linux-2.6.8.1.
Message-Id: <20041021004733.GA17038@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10410201927410.10087-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10410201927410.10087-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Oct 20, 2004 at 08:05:10PM +0100, Mark Fortescue wrote:
> I am having a lot of trouble getting things up and running on my sparc
> clone. I have applied a patch to get the PROM Console working and I would
> like some help getting the CGthree console up and running as the code has
> changed substantially from the V2.2 kernels and I can't find the areas of
> code to change.
> In addition, it would be nice if the floppy was detected. The 2.2.x
> kernels also fail to find it.
> The console problems are:
> 1) The console blanks at the point then it switches from the prom console
> to the frame buffer console. (There is an error in cg3.c as both blanking
> and unblanking to the same thing. I thought that I had fixed this with the
> patch below [based on the code from the 2.2.26 kernel] but this had no
> effect. Maybe I changed the wrong case).

Okay, this is nasty. I don't have any ideas.


-- wli
