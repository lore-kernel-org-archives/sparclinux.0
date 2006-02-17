From: "Leif Sawyer" <lsawyer@gci.com>
Date: Fri, 17 Feb 2006 18:15:32 +0000
Subject: RE: [gentoo-sparc] kernel-2.6.15-r4 (in)stability on U2-SMP, etc.
Message-Id: <38D04BF3A4B7B2499D19EB1DB54285EA01F198ED@FNB1EX01.gci.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1140008955.4844.42.camel@polylepis.inforead.com>
In-Reply-To: <1140008955.4844.42.camel@polylepis.inforead.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Ferris McCormick wrote in response to
> On Wed, 2006-02-15 at 08:28 -0500, Jameel Akari wrote:
>> On Wed, 15 Feb 2006, Ferris McCormick wrote:
>> 
>>> However, U2-SMP(2x450) is not.  As is the case with ALL 2.6.xx 
>>> kernels,2.6.15-r4 cannot handle the sort of disk activity which
>>> portage requires
>> 
>> If you have 400MHz/2MB CPUs sitting around it may be worth testing 
>> with them to isolate that as a cause.
>  
> As is too often the case, I mistyped.  The stable system is 
> U60(2x450); the unstable system is U2(2x400).  Thanks for 
> catching this.

I can also add that my U2 (2x300) is also having the same lockup
on high disk activity.  I've been able to 'nice' my portage related
activity down and avoid it crashing on the last few package emerges,
but it's not a cure-all.

