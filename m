From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 08:44:26 +0000
Subject: Re: [PATCH 6/7] sparc32,leon: operate on boot-cpu IRQ controller
Message-Id: <4DAE9CEA.6010109@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Wed, 20 Apr 2011 10:35:55 +0200
>
>  
>
>>David Miller wrote:
>>
>>    
>>
>>>It was terrible when I had to fix this on sparc64.
>>> 
>>>      
>>>
>>I think it is a quite big job, and not really related. I can drop this
>>cleanup patch now and make a proper implementation later this
>>year. What I want is get more important stuff working with genirq
>>first.
>>    
>>
>
>So like you said, leave this cleanup for later.
>  
>
Ok, since the affinity patch depends on it, I will update according to 
Sams comments and resend it. The affinity patch will be patch 7/7 and 
6/7 should be dropped.

Daniel
