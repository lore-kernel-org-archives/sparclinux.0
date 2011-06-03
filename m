From: Daniel Hellstrom <daniel@gaisler.com>
Date: Fri, 03 Jun 2011 07:27:47 +0000
Subject: Re: [PATCH 1/3 v3] sparc32: added CONFIG_PCIC_PCI Kconfig setting
Message-Id: <4DE88CF3.5010907@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1306220688-8438-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1306220688-8438-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Julian Calaby <julian.calaby@gmail.com>
>Date: Wed, 25 May 2011 08:47:41 +1000
>
>  
>
>>On Tue, May 24, 2011 at 17:04, Daniel Hellstrom <daniel@gaisler.com> wrote:
>>    
>>
>>>@@ -1650,7 +1650,7 @@ pcic_nmi_trap_patch:
>>>        rd     %psr, %l0
>>>       .word   0
>>>
>>>-#endif /* CONFIG_PCI */
>>>+#endif /* CONFIG_PCI_PCIC */
>>>      
>>>
>>This should be CONFIG_PCIC_PCI
>>    
>>
>
>I fixed this up when applying the patches.
>  
>
Thanks all for the previous comments and for finding and fixing this 
particular problem. Thanks for applying the patches.

Best Regards,

Daniel
