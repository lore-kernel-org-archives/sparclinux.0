From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 05 Mar 2018 20:56:52 +0000
Subject: Re: [PATCH v12 09/11] mm: Allow arch code to override copy_highpage()
Message-Id: <2a558ec8-c46c-299e-2f14-bb33058cbd90@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
 <68ee1cbc-8e21-e693-7878-777e0d5b0f0c@linux.intel.com>
 <8b441f99-ee41-e113-f52d-dbe0573bf267@oracle.com>
In-Reply-To: <8b441f99-ee41-e113-f52d-dbe0573bf267@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org, davem@davemloft.net
Cc: kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, anthony.yznaga@oracle.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

On 03/05/2018 12:42 PM, Khalid Aziz wrote:
> On 03/05/2018 12:24 PM, Dave Hansen wrote:
>> On 02/21/2018 09:15 AM, Khalid Aziz wrote:
>>> +#ifndef __HAVE_ARCH_COPY_HIGHPAGE
>>> +
>>>   static inline void copy_highpage(struct page *to, struct page *from)
>>>   {
>>>       char *vfrom, *vto;
>>> @@ -248,4 +250,6 @@ static inline void copy_highpage(struct page *to,
>>> struct page *from)
>>>       kunmap_atomic(vfrom);
>>>   }
>>>   +#endif
>>
>> I think we prefer that these are CONFIG_* options.
> 
> I added this mechanism to be same as what we have for copy_user_highpage():
> 
> ---------------
> #ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE

I think that's the old way that we generally don't want to add new
instances of.
