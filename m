From: Stanley Benoit <sbenoit@verizon.net>
Date: Fri, 12 Nov 2004 22:05:38 +0000
Subject: Re: page.h question
Message-Id: <FC6D7457-34F6-11D9-A583-000D93B069F6@verizon.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5628F39A-34F2-11D9-A583-000D93B069F6@verizon.net>
In-Reply-To: <5628F39A-34F2-11D9-A583-000D93B069F6@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Nov 12, 2004, at 4:39 PM, David S. Miller wrote:

> On Fri, 12 Nov 2004 16:32:21 -0500
> Stanley Benoit <sbenoit@verizon.net> wrote:
>
>> <--------------------     snip ------------------------>
>>
>> /* I have my suspicions... -DaveM */
>> 19 #define PAGE_SIZE    (1UL << PAGE_SHIFT)
>> 20 #else
>> 21 #define PAGE_SIZE    (1 << PAGE_SHIFT)
>> 22 #endif
>> 23 #define PAGE_MASK    (~(PAGE_SIZE-1))
>> 24
>>
>> <----------- end snip ----------------->
>>
>> Does anyone know what Dave M. was suspicious about....?
>
> The assembler doesn't grok the "UL" thing normal C
> parsing does.
David,

Thank you.

Stan Benoit<sbenoit@verizon.net>
http://www.mondorescue.org	
http://troff.nakedsoul.org

