Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058793CB2FD
	for <sparclinux@vger.kernel.org>; Thu, 18 Jun 2026 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767806; cv=none; b=dA3/coiNKKJnJCxKhRpk3eLKSRlEo0hcIhlUy+nApuTe1T2ViGP0f2Sr4T79eQwODCXyUrMdnTcnkr1iBxKxfo2OMlSjVoBd+DhtAwQkUmOiK2AUNKE/dT5+GKWwcOZUQtAsZrtVinpSM0r2B/il4TIiE1fN8ofVST4y+40kU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767806; c=relaxed/simple;
	bh=JEnKD1wFAoz9j9E5jUkwUH3p254IwBGXQXfzzoIk2VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHSiMJSMfuT3YT4Uyp6mjSVlFCotUeS38wlIybIwHfOjug/J/bPPLuEwyxriUZwEW6Q8+K6DHbAqXyh1nkf04HwWGa59uS2qWrogHWqbanez80cMN96PdFpaCl1Tuzm2N9Ump6N+MdhEwLXBZf737rsvuE+6zBZXIzJGPbri350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIxRQhiN; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIxRQhiN"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30bf854d5feso397150eec.0
        for <sparclinux@vger.kernel.org>; Thu, 18 Jun 2026 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781767803; x=1782372603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VKjXhnSsBnhZ4F08z0E4PlAmKDbxADWEf7nB5X3WBlw=;
        b=NIxRQhiNKCI+p/FhCWgxGH6DmZ/B0c/rS3b0UYLul48ol5L53JFmcgz2nvJHkv0qSC
         vGxqZrqk76dcfBJKnlqzj/rPyxjw0DHYJuN54LtFJCSPj7goGSyVYmc8pQ2xchmP98/A
         cd9z5v4vzxhAGKEprTkhIO8JGPmOVgihR4CXcEl7/85OxcMXeqcsKHKznpulQmaePleu
         mqraatjsgxWcesPAKbsQ2gHGACWtVPux1IXTszA4LBopqSWMHQ2pVAVx33iTVB9ocgrA
         27oG1+8cwKz5UsWW0YG+2JaVFKL/dXXx9AfWbg5O9PJGEEoeLyjlK1FvyIfTRhWE9VmP
         YXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781767803; x=1782372603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKjXhnSsBnhZ4F08z0E4PlAmKDbxADWEf7nB5X3WBlw=;
        b=mAwKneEJhDLELWluvh7fX5Opa89eIRAknMAsyFWisZaeEkwbHn+mdNX/y7RfCb4FrT
         Mfm5En8llNgoifQjdSwAESFbJVZuiOXh67ofBBaVOGVGHCQTiLVWp4S8ZgN1JCo1hilx
         /rzGZs0tg3fap2wJANbgn/WlV9lZJ8psAbiJ8tepIjbb2UPXNtLb2UZsPSsHVedlnr3U
         6PRZ9PhumDS2SSVse4vtRCR5sWmvuJAgBkUtdzGaGI5P/UqlGB1uqff3tzpB9nAGmUrr
         xmSJnKrubCvjr354uQy7w/g1zLT4mD0HsR0o/lj8FHG9kzFPHTmLVhyB1FbaIZnz3YW3
         2i1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9+Tm5XGnCXKweB3HbmYwQcS7hrc0gvSByFjKdUjmXs97Mvo3BzIxGd/7oYdwrElmwAzhbPVGwydzEY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ETuYTQE6X9K9Vb2kkCyw52BHk/s23e+kaSSSVahYCMJ+0vMA
	WxWe21ulbXAetD2ck4RiTHpdj+ojDo3YvZwgg5SBDPWlouOXGhzvq0Lc
X-Gm-Gg: AfdE7ckM3RI8vAsFQ8fLtHlTkQYqHnTkw/SVxMNbFipAuvWxMBmtN2kybyFViESXy2z
	abjhkHpuGU2kvFUwjh6AF4lQtTNDKa7g1A9f9HOA4DH1adf/4/VsVt7gF4vNU3fPuwOLUDxc+CX
	uylXzEYQ55WoWi16bpcR36TCavMwXvVgR6kpHzieHyBmRIBdREFvgJK9ssOd0JiS7vBAcNKMUqU
	aJAED1/8kVbUacAsDvzc0GL1lpQVVI969bHuR8zmb0p4mvnAgCOYSCwrOHRoeIR7jIxc6TBdqLX
	tHDOvsG3YBk1T1ts0iP5D3v0mFOFGlniwliqknHactFNlnu3iks+C7La8S9WnG2yOnaDGpx4EgH
	p1EqnvXNMo0lpDAeSWsOH/FmrrOkbWL0ZwoBKRh6Eh2GA7OGMcq8YvmGKHr0r7YX56cu5NbWFRw
	zgEY5lE58x45sD9HGY
X-Received: by 2002:a05:7300:e68b:b0:30b:e540:4260 with SMTP id 5a478bee46e88-30bf0948038mr1654274eec.19.1781767802774;
        Thu, 18 Jun 2026 00:30:02 -0700 (PDT)
Received: from [192.168.21.192] ([24.18.106.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bcbb684absm5195050eec.1.2026.06.18.00.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 00:30:02 -0700 (PDT)
Message-ID: <d58e1648-65b9-479e-97f4-1bbe4cf44799@gmail.com>
Date: Thu, 18 Jun 2026 00:29:59 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 1/1] sparc64: unify thread stack sizing and add explicit
 32KB stack
Content-Language: en-US
To: Andreas Larsson <andreas@gaisler.com>,
 David Laight <david.laight.linux@gmail.com>,
 Andreas Larsson <andreas.larsson@gaisler.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, thuth@redhat.com, regressions@lists.linux.dev,
 glaubitz@physik.fu-berlin.de
References: <20260519075809.8993-1-unixpro1970@gmail.com>
 <20260519075809.8993-2-unixpro1970@gmail.com>
 <03111ac5-0055-425f-a7f2-54d4f2bb4988@gaisler.com>
 <20260616205851.428ca70c@pumpkin>
 <d634e2f2-daf0-4328-bf16-7f5bff6fe851@gaisler.com>
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <d634e2f2-daf0-4328-bf16-7f5bff6fe851@gaisler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/17/26 10:53 PM, Andreas Larsson wrote:
> On 2026-06-16 21:58, David Laight wrote:
>> On Tue, 16 Jun 2026 16:18:33 +0200
>> Andreas Larsson <andreas.larsson@gaisler.com> wrote:
>>
>>> On 2026-05-19 09:57, Tony Rodriguez wrote:
>>>> This patch restructures the thread‑stack sizing logic into a single
>>>> if / elif / else chain and introduces an explicit 32KB kernel stack
>>>> for SPARC64. The previous implementation relied on nested conditionals
>>>> and PAGE_SHIFT‑dependent behavior, which produced 8KB or 16KB stacks
>>>> depending on configuration. SPARC64 requires a larger,
>>>> architecture‑specific stack due to its trapframe size, register‑window
>>>> behavior, and deeper call paths.
>>>>
>>>> A reproducible failure case occurs when usbcore is enabled: USB hub
>>>> enumeration (usb_new_device(), hub_port_connect(), PM/QoS helpers)
>>>> allocates large on‑stack structures and recurses through several
>>>> layers of device‑model code. Combined with SPARC64’s trapframe and
>>>> register‑window overhead, this reliably exhausts a 16KB stack and
>>>> results in early‑boot panics.  A 32KB stack eliminates these failures.
>>>>
>>>> The new logic is:
>>>>      SPARC64:
>>>>          THREAD_SIZE = 4 * PAGE_SIZE (32KB)
>>>>          THREAD_SHIFT = PAGE_SHIFT + 2 (log₂(32KB))
>>>>          THREAD_SIZE_ORDER = 2 (4 contiguous pages)
>>> Yes
>>>
>>>>      Non‑SPARC64 with PAGE_SHIFT == 13:
>>>>          Retains the existing 16KB stack behavior
>>>>      Fallback:
>>>>          Retains the existing 8KB stack behavior
>>> No, not to my understanding, see comments below.
>>>
>>>> Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
>>>> ---
>>>>   arch/sparc/include/asm/thread_info_64.h | 28 ++++++++++++-------------
>>>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
>>>> index c8a73dff27f8..6b12a2b66385 100644
>>>> --- a/arch/sparc/include/asm/thread_info_64.h
>>>> +++ b/arch/sparc/include/asm/thread_info_64.h
>>>> @@ -99,13 +99,20 @@ struct thread_info {
>>>>   #define FAULT_CODE_BLKCOMMIT	0x10	/* Use blk-commit ASI in copy_page */
>>>>   #define	FAULT_CODE_BAD_RA	0x20	/* Bad RA for sun4v		   */
>>>>
>>>> -#if PAGE_SHIFT == 13
>>>> -#define THREAD_SIZE (2*PAGE_SIZE)
>>>> -#define THREAD_SHIFT (PAGE_SHIFT + 1)
>>>> -#else /* PAGE_SHIFT == 13 */
>>>> -#define THREAD_SIZE PAGE_SIZE
>>>> -#define THREAD_SHIFT PAGE_SHIFT
>>>> -#endif /* PAGE_SHIFT == 13 */
>>>> +/* thread information allocation */
>>>> +#ifdef CONFIG_SPARC64
>>>> +	#define THREAD_SIZE (4 * PAGE_SIZE)
>>>> +	#define THREAD_SHIFT (PAGE_SHIFT + 2)
>>>> +	#define THREAD_SIZE_ORDER 2
>>> As far as I can see, given that this header is included by
>>>
>>> #if defined(__sparc__) && defined(__arch64__)
>>> #include <asm/thread_info_64.h>
>>> #else
>>> #include <asm/thread_info_32.h>
>>> #endif
>>>
>>> the code above is the only code that will ever be compiled, while leaving...
>>>
>>>> +#elif PAGE_SHIFT == 13
>>>> +	#define THREAD_SIZE (2 * PAGE_SIZE)
>>>> +	#define THREAD_SHIFT (PAGE_SHIFT + 1)
>>>> +	#define THREAD_SIZE_ORDER 1
>>>> +#else
>>>> +	#define THREAD_SIZE PAGE_SIZE
>>>> +	#define THREAD_SHIFT PAGE_SHIFT
>>>> +	#define THREAD_SIZE_ORDER 0
>>>> +#endif
>>> ...this code dead, where the else branch code already was dead (but then
>>> in two separate else braches).
>>>
>>> I'd rather see the else branch here and the else branch below cleaned up
>>> by a separate patch with a fixup tag for commit 15b9350a177b ("sparc64:
>>> Only support 4MB huge pages and 8KB base pages.") that as far as I can
>>> see should have removed the else branch. The else branches was to use
>>> only one page when the page size was _larger_ than 8 KiB when that was
>>> an option.
>> That whole logic is impenetrable.
>> Why not set the 'desired thread size' in kB, then work out how many
>> pages that ends up being based on the page size, and finally get the actual
>> stack size.
>> I'm not sure, but with vmalloc()ed stacks and 8k pages can't you have 24kB?
> No, the next step up is 32 KiB as the stack allocation is sized by
> THREAD_SIZE_ORDER.
>
> Cheers,
> Andreas
>

After additional testing and debugging on a SPARC64 S7-2 system running 
kernel v7.1-mainline, I've made several important observations regarding 
the USB core stack overflow issue.

1. The Stack Overflow is Real and Consistent

My initial patch (increasing kernel stack to 32KB) appears to work with 
v7.1-mainline as well. However, the underlying problem remains: the USB 
core's stack usage consistently exceeds the default 16KB limit during 
hub enumeration.

2. The "Static Analysis vs. Runtime Reality" Contradiction

When I compile the kernel with -fstack-usage to generate .su files, the 
static analysis shows small stack frames for all USB core functions.

  For example:

hub_event:      2457 bytes  (static)
hub_activate:   1892 bytes  (static)
usb_control_msg: 1248 bytes (static)

However, my runtime stack tracing shows a dramatically different picture:

STACKTRACE: hub_event():entry: 31856 bytes used
STACKTRACE: hub_activate():entry: 31680 bytes used
STACKTRACE: usb_control_msg():entry: 30768 bytes used

Please see:

https://github.com/unixpro1970/Sparc64-Kernel-Debugging-Dumps/blob/main/usbcore-stacktrace.txt

Perhaps the issue is the accumulation of register window spills across 
multiple nested function calls?

3. The 32KB Limit is Also at Risk

I've observed that stack usage can approach the 32K limit as well.

4. Testing:

TO DO: I will try adding a stack flush at the entry and exit of 
hub_event() .  Hopefully it will prevent the accumulation of register 
windows. The theory is that flushing register windows between work items 
may prevent the stack growth from carrying over from one event to the next.

If the flush helps, I may also look into "stack_trace_flush" David 
Miller's stack_trace_flush() implementation. Unsure if stack_trace_flush 
is supported with v7.1.


Regards,

Tony


