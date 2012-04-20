From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 20 Apr 2012 14:46:37 +0000
Subject: Re: sparc - generic clock event support
Message-Id: <20120420144637.GA2867@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120404200704.GA16958@merkur.ravnborg.org>
In-Reply-To: <20120404200704.GA16958@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Apr 20, 2012 at 10:21:51AM +0200, Konrad Eisele wrote:
>> I runtime tested your patch. For single-CPU the patch works
>> fine. For SMP I cannot test because Leon-SMP for 3.x doesnt
>> work right now, also without your patch. The last version
>> that I could verify LEON-SMP was 2.6.36, 3.0 should also work,
>> however there your patches dont apply. I'll have to make
>> Leon-SMP work with 3.4 first , then I can test the SMP part
>> of the patch. However I'll write this on my todo list for
>> after easter. As for Leon-SMP is broken right now I would
>> vote for that your patches are applied now and after that to
>> try to fix Leon-SMP.
>> -- Konrad
>
> With SMP working again I tested your timer patch for sparc-leon
> SMP. It works!

Great - thanks for testing and letting us know!

	Sam
