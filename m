From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Sun, 02 Jan 2005 19:50:50 +0000
Subject: Re: Boot failures - untrapped exception?
Message-Id: <1104695450.4193.9.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0501021218460.3200@bobcat>
In-Reply-To: <Pine.LNX.4.61.0501021218460.3200@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 2005-01-02 at 13:26 -0500, Jurij Smakov wrote:
> I was actually unable to find 
> any kernel function, which outputs the line "FP Disabled", so I assume 
> (for now) that it comes from OBP.
Yes it comes from OBP. You get it because a floating point instruction
has been executed but the FP unit is disabled. I remember having this
problem many years ago working with gcc on custom bootloader code.

>  This supports a theory that somewhere in 
> the execution path of inherit_prom_mappings() a floating-point instruction 
> is used, triggering a "Floating Point Disabled" trap. As kernel's own trap 
> handling is getting set up later, it gets (mis)handled by OBP instead. 
> Major questions are a) where this instruction might be located and b) why 
> isn't it triggered every time. I would appreciate any input which would 
> help to identify and debug this problem.
> 
As I remember the problem turned out to be that gcc was using floating
point registers for temporary storage (or something like that). The
solution was to make sure that the right command line options for gcc
were used.

To find the instruction you should be able to use objdump to disassemble
the code and then search for floating point registers being used.

Actually there are a few ways that you might be able to get some stuff
out of OBP. When you drop back to the ok prompt use

ctrace

to get a stack dump

ftrace might also give you interesting information but that is forth's
stack and I doubt that the problem is located in forth code.

Richard

-- 
Richard Mortimer <richm@oldelvet.org.uk>

