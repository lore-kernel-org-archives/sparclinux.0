From: David L Stevens <david.stevens@oracle.com>
Date: Fri, 05 Sep 2014 17:10:30 +0000
Subject: Re: commit 8c86e70acead629aacb4afcd818add66bf6844d9 hangs SPARC64 LDOMs
Message-Id: <5409EE86.9010807@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5409D2C3.6010806@oracle.com>
In-Reply-To: <5409D2C3.6010806@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Vivek,
	That fixes it -- thanks!

				+-DLS

On 09/05/2014 12:23 PM, Vivek Goyal wrote:
> 
> Hi David,
> 
> I put one more commit on top in -rc3 to fix UML crash.
> 
> commit 800df627e2eabaf4a921d342a1d5162c843b7fc2
> Author: Vivek Goyal <vgoyal@redhat.com>
> Date:   Fri Aug 29 15:18:29 2014 -0700
> 
>     resource: fix the case of null pointer access
> 
> 
> Can you try applying this patch on top of net-next and see if helps
> fix the issue.
> 
> If not, then it probably is a different issue. Is there anything on
> the console? I will need to know some more information to figure out
> what's wrong.
> 
> Thanks
> Vivek
> 
> On Fri, Sep 05, 2014 at 11:12:03AM -0400, David L Stevens wrote:
>>
>> I was trying to rebase some patches to the latest net-next and I found that the LDOMs
>> (Solaris virtual machines) hang on boot.
>>
>> git bisect narrowed to commit 8c86e70acead629aacb4afcd818add66bf6844d9 and reverting
>> that makes it work again.
>>
>> commit 8c86e70acead629aacb4afcd818add66bf6844d9
>> Author: Vivek Goyal <vgoyal@redhat.com>
>> Date:   Fri Aug 8 14:25:50 2014 -0700
>>
>>     resource: provide new functions to walk through resources
>>
>>     I have added two more functions to walk through resources.
>>
>> 						+-DLS
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
