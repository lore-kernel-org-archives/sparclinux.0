From: Jim Gifford <maillist@jg555.com>
Date: Sat, 14 Apr 2007 17:11:17 +0000
Subject: Re: Running Glibc Testsuite - Eeek! page_mapcount(page) went negative!
Message-Id: <46210B35.5090401@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4620FAE9.4010904@jg555.com>
In-Reply-To: <4620FAE9.4010904@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Jim Gifford <maillist@jg555.com>
> Date: Sat, 14 Apr 2007 09:01:45 -0700
>
>   
>> I was compiling glibc like I have done several times before, but the 
>> last 3 times with the 2.6.20.x series of kernel when the testsuite runs 
>> I get the following error. I've seen this issue reported on LKML but no 
>> fixes. I'm compiling on a Netra T1.
>>
>> Eeek! page_mapcount(page) went negative! (-1)
>> page pfn = 0
>> page->flags = 400
>> page->count = 1
>> page->mapping = 0000000000000000
>> vma->vm_ops = 0x8
>>     
>
> Can you point me at one of the LKML reports that look like this
> one?  Thanks.
>   
http://www.uwsg.iu.edu/hypermail/linux/kernel/0701.1/0979.html
http://lists.openwall.net/linux-kernel/2007/01/07/162
http://hulllug.principalhosting.net/archive/index.php/t-226829.html
http://www.linuxrocket.net/index.cgi?a=MailArchiver&ma=ShowMail&IdF8815

These are the ones I found, looks like one of them is pretty old.
