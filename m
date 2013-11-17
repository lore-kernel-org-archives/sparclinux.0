From: Meelis Roos <mroos@linux.ee>
Date: Sun, 17 Nov 2013 20:52:56 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <alpine.SOC.1.00.1311172250350.2495@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> First I compared the configurations of working and nonworking machines 
> (there were 2 different machines from the same era with problem), then 
> did some conf bisecting and found that CONFIG_SUN_OPENPROMFS causes the 
> RED problem in 3.12-rc5 when compiled modular and module loaded. It did 
> not happen when it was compiled statically, or modular but module was 
> not loaded. Reduced minimalistic configuration that causes this on Ultra 
> 5 is attached to this mail.
> 
> With the minimalistic conf, I redid the bisect with a different range 
> end, fixing vmalloc.h include when needed. This led me into tty changes 
> again, maybe more precise this time because of vmalloc fixes (no commits 
> skipped this time). This is the culprit today:
> 
> 20bafb3d23d108bc0a896eb8b7c1501f4f649b77 is the first bad commit
> commit 20bafb3d23d108bc0a896eb8b7c1501f4f649b77
> Author: Peter Hurley <peter@hurleysoftware.com>
> Date:   Sat Jun 15 10:21:19 2013 -0400
> 
>     n_tty: Move buffers into n_tty_data
>     
>     Reduce pointer reloading and improve locality-of-reference;
>     allocate read_buf and echo_buf within struct n_tty_data.
>     
>     Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> :040000 040000 96d92e4e242c4b2ff11b25c005bccd093865b350 
> 2822d87b2425c3e7adc7b722a20d739c9d4a3046 M      drivers
> 
> This patch seems to switch ldata with its read_buf and echo_buf from 
> kmalloc/kfree to vmalloc/vfree (the bufs are now inlined in ldata, not 
> separately allocated).
> 
> More fields in ldata are now explicitly initialized to zero instead of 
> kzalloc doing it before. However, I do not see the initialization of 
> some of the fields - maybe they are done later in the code? I noticed 
> process_char_map, raw, real_raw, icanon, read_buf, echo_buf that were 
> zeroed before but I did not find explicit zeroing of them after the 
> patch. However, just adding a memset to zero ldata after vmalloc does 
> not change anything.

Additional quick test of reverting just the vmalloc vs kmalloc (and 
corresponding free) of ldata (but not the inlining of other arrays into 
it) works around the problem (but it tries to alloc a bigger chunk with 
kmalloc so it is proably not a good solution, just a workaround).

-- 
Meelis Roos (mroos@linux.ee)
