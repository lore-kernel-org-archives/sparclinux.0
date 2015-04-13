From: David Ahern <david.ahern@oracle.com>
Date: Mon, 13 Apr 2015 17:53:03 +0000
Subject: Re: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <552C027F.8030309@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 3/20/15 1:38 PM, David Miller wrote:
> From: David Ahern <david.ahern@oracle.com>
> Date: Thu, 19 Mar 2015 20:55:27 -0600
>
>> On 3/19/15 7:56 PM, David Miller wrote:
>>> Applied, but two questions:
>>>
>>> 1) Why didn't you have to deal with the overflow event
>>>      latching issues I address in sparc_vt_write_pmc()?
>>
>> I saw the note. I need to understand why you wrote that. Relevant
>> sections of the PRM for the T4 and the M7 have the same wording, so I
>> was surprised to read that. Perhaps a h/w (or h/w revision) quirk?
>>
>> It was not needed for the M7 -- bare metal or LDOM -- so I opted to go
>> with the purist approach based on the PRM. As I get time and access to
>> hardware I will take a look at the T4.
>
> I hate having inconsistencies like this.
>
> My two big stress tests were:
>
> 1) "perf record make -s -j128" of a kernel build on my T4-2
>
> 2) Same kernel build, but instead of using perf record, I ran
>     "perf top" in another window while "make -s -j128" was
>     happening.
>
> Eventually, especially in case #2, events simply stopped being
> recorded.

T7-4 showed no problems with the patch that was accepted. Through 
several 'perf record -- make -j 1024' sessions (make clean in between) 
and with a perf-top running in a separate window for a long period of 
time, all sessions continued to see samples.

I changed the T4 write_pmc handler to use the m7 variant:

+static void sparc_m7_write_pmc(int idx, u64 val);

  static const struct sparc_pmu niagara4_pmu = {
         .event_map      = niagara4_event_map,
         .cache_map      = &niagara4_cache_map,
         .max_events     = ARRAY_SIZE(niagara4_perfmon_event_map),
         .read_pmc       = sparc_vt_read_pmc,
-       .write_pmc      = sparc_vt_write_pmc,
+       .write_pmc      = sparc_m7_write_pmc,
         .upper_shift    = 5,
         .lower_shift    = 5,
         .event_mask     = 0x7ff,

and a T4-1 showed no problems either (-j 64 for this one).

David
