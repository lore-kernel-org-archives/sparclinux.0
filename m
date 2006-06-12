From: Bob Breuer <breuerr@mc.net>
Date: Mon, 12 Jun 2006 06:43:25 +0000
Subject: vmalloc can clobber framebuffer on sparc32
Message-Id: <448D0D0D.8080606@mc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Bob Breuer <breuerr@mc.net>
> Date: Sun, 11 Jun 2006 20:21:09 -0500
> 
>> David Miller wrote:
>>> But why in the world does the scheduler "lock up" just because the
>>> migration cost is too large?
>> There is an address space collision between the vmalloc area and where
>> the prom maps the framebuffer.
> 
> And this is what locks up the scheduler when a bad migration cost
> calculation is made?

The migration cost setup by default did a vmalloc of 10MB therefore
clobbering the address space used by the framebuffer.  The next screen
redraw would access something other than the framebuffer, or fail if it
was vfree'd in the meantime.  Either way, it silently goes downhill
because the console can't display the error messages to the screen.

> Please start a new thread if you are talking about some new topic,
> it gets confusing :-/
> 
>> The vmalloc range is 0xfe600000 to 0xffc00000.  I have a cg6 that gets
>> mapped to 0xfee00000, and a cg14 with 8MB vsimm that gets mapped to
>> 0xfe700000.  These leave only 8MB and 1MB of usable vmalloc space before
>> bad things happen.
>>
>> We may want to find a different vm hole to put vmalloc into.  Is there
>> any documentation on what address spaces are reserved with the different
>> prom versions?
> 
> I don't know, but from your report it seems that OBP takes
> 0xfe000000 up to 0xfff00000.
> 
> Actually, you can look at the "available" property of the
> virtual-memory node.  Or, you can see if there is a "translations"
> node in the /virtual-memory node like there is on sparc64.

Ok, here are the available regions reported with a cg14 framebuffer:
  00000000.fff00000.00100000
  00000000.fef00000.00e00000
  00000000.00000000.fe400000
  00000000.ffe3f000.00081000
  00000000.ffd00000.00026000
  00000000.fe400000.00300000

after rearrange and fill gaps:
   start  -  end    (  size  )   type
  00000000-fe3fffff (fe400000)  free
  fe400000-fe6fffff (00300000)  free
    fe600000 = VMALLOC_START
  fe700000-feefffff (00800000)  unavail (cg14 framebuffer)
  fef00000-ffcfffff (00e00000)  free
    ffc00000 = VMALLOC_END
  ffd00000-ffd25fff (00026000)  free
  ffd26000-ffe3efff (00119000)  unavail
  ffe3f000-ffebffff (00081000)  free
  ffec0000-ffefffff (00040000)  unavail
  fff00000-ffffffff (00100000)  free

The framebuffer sitting in the middle of the vmalloc range is what
causes the problem.

Bob
