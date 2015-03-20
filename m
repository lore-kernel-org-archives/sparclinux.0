From: David Miller <davem@davemloft.net>
Date: Fri, 20 Mar 2015 19:38:29 +0000
Subject: Re: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <20150320.153829.1830197565399382412.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Thu, 19 Mar 2015 20:55:27 -0600

> On 3/19/15 7:56 PM, David Miller wrote:
>> Applied, but two questions:
>>
>> 1) Why didn't you have to deal with the overflow event
>>     latching issues I address in sparc_vt_write_pmc()?
> 
> I saw the note. I need to understand why you wrote that. Relevant
> sections of the PRM for the T4 and the M7 have the same wording, so I
> was surprised to read that. Perhaps a h/w (or h/w revision) quirk?
> 
> It was not needed for the M7 -- bare metal or LDOM -- so I opted to go
> with the purist approach based on the PRM. As I get time and access to
> hardware I will take a look at the T4.

I hate having inconsistencies like this.

My two big stress tests were:

1) "perf record make -s -j128" of a kernel build on my T4-2

2) Same kernel build, but instead of using perf record, I ran
   "perf top" in another window while "make -s -j128" was
   happening.

Eventually, especially in case #2, events simply stopped being
recorded.

I really want to get to the bottom of this rathern than putting our
hands in our pockets and saying "meh".
