From: Peter Hurley <peter@hurleysoftware.com>
Date: Mon, 18 Nov 2013 13:51:25 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <528A1B5D.4030803@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

[ +cc David Miller because he probably knows how sparc prom console works ]

On 11/17/2013 03:35 PM, Meelis Roos wrote:
>>>> Somwehere between 3.11.0 and 3.12-rc2, my U5-360 has consistently been
>>>>> hanging on reboot. Today I connected a serial cable and learned about a
>>>>> RED state exception. 3.10.0 and 3.11.0 are OK, 3.12-rc2 and later hang
>>>>> reliably. I have not yet started bisecting since this will need remote
>>>>> power cycle setup.
>>> Another data point: the same problem happens on Sun Blade 100 with ALI
>>> IDE. Does not happen on Fire V100 and Netra X1 that are also ALI IDE
>>> based. The configs may be different too of course.
>>>
>>> I did a bisect for full tree. It landed into tty commits, some of them
>>> being untestable without a compile fix
>>
>> Hi Meelis,
>>
>> What tty commits required a compile fix?
>
> Several needed including of <linux/vmalloc.h> otherwise vmalloc and
> vfree were unknown.

Yeah. Sorry about the bisect breakage. The problem was caught right away
with commit 86e35aea477f4cc5a724d8704f5e9d956c73d424, 'n_tty: Fix build
breakage on ppc64' but that doesn't help bisect.

>>> but it came out clearly finally
>>> (each bad commit was clearly bad, each good commit was tested for 3
>>> reboots without a problem). Bisect resulted in his commit being at
>>> fault:
>>>
>>> 8cb06c983822103da1cfe57b9901e60a00e61f67 is the first bad commit
>>> commit 8cb06c983822103da1cfe57b9901e60a00e61f67
>>> Author: Peter Hurley<peter@hurleysoftware.com>
>>> Date:   Sat Jun 15 10:21:18 2013 -0400
>>>
>>>       n_tty: Remove alias ptrs in __receive_buf()
>>>
>>>       The char and flag buffer local alias pointers, p and f, are
>>>       unnecessary; remove them.
>>>
>>>       Signed-off-by: Peter Hurley<peter@hurleysoftware.com>
>>>       Signed-off-by: Greg Kroah-Hartman<gregkh@linuxfoundation.org>
>>>
>>> :040000 040000 ddc901fe810f43bc06a64397735b469b11e403e8
>>> 96d92e4e242c4b2ff11b25c005bccd093865b350 M  drivers
>>>
>>> Reading the commit suggests that commit is not at fault - it seems so
>>> unrelated. It just modifies on-stack function parameters instead of
>>> local copies.
>>
>> As you note, this is an unlikely culprit. Does a repeat bisect from
>> different good/bad starts give the same result?
>
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
>      n_tty: Move buffers into n_tty_data
>
>      Reduce pointer reloading and improve locality-of-reference;
>      allocate read_buf and echo_buf within struct n_tty_data.
>
>      Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> :040000 040000 96d92e4e242c4b2ff11b25c005bccd093865b350
> 2822d87b2425c3e7adc7b722a20d739c9d4a3046 M      drivers
>
> This patch seems to switch ldata with its read_buf and echo_buf from
> kmalloc/kfree to vmalloc/vfree (the bufs are now inlined in ldata, not
> separately allocated).

Yep, this makes more sense than the original bisect.

> More fields in ldata are now explicitly initialized to zero instead of
> kzalloc doing it before. However, I do not see the initialization of
> some of the fields - maybe they are done later in the code? I noticed
> process_char_map, raw, real_raw, icanon, read_buf, echo_buf that were
> zeroed before but I did not find explicit zeroing of them after the
> patch. However, just adding a memset to zero ldata after vmalloc does
> not change anything.
>
> Openpromfs does not seem to be changed after 3.11 and it does not seem
> to use any tty layer functions.
>
> I still have no idea how it would interact.

Me neither. But it looks like something depends on tty working before
the mmu is initialized. David, would you know what that is?

It'd be nice to know what that is because even though this was going
to be rolled back, vmalloc() was going to be the backup option.

Regards,
Peter Hurley


