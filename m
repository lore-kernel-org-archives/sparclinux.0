From: David Miller <davem@davemloft.net>
Date: Fri, 20 Mar 2015 19:50:01 +0000
Subject: Re: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <20150320.155001.1297794205297363698.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Fri, 20 Mar 2015 13:41:37 -0600

> On 3/20/15 1:38 PM, David Miller wrote:
>> My two big stress tests were:
>>
>> 1) "perf record make -s -j128" of a kernel build on my T4-2
>>
>> 2) Same kernel build, but instead of using perf record, I ran
>>     "perf top" in another window while "make -s -j128" was
>>     happening.
>>
>> Eventually, especially in case #2, events simply stopped being
>> recorded.
> 
> I am spending a lot of time on perf right now; will add those 2 cases
> to the list.

Thanks a lot.
