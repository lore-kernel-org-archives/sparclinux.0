From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Wed, 12 Jul 2017 04:42:51 +0000
Subject: Re: sun4v+DMA related boot crash on 4.13-git
Message-Id: <7b20cf43-19ef-5fc0-bbee-bee6fa481454@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <60fa7a06-d319-9b6f-aba8-7b63014a1120@oracle.com>
 <20170711.173436.720922946430226024.davem@davemloft.net>
 <94c3900e-781e-da0e-e1fe-ad1239ed8dee@oracle.com>
 <20170711.210200.1257637169180312170.davem@davemloft.net>
In-Reply-To: <20170711.210200.1257637169180312170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On 07/11/2017 09:02 PM, David Miller wrote:
> From: Tushar Dave <tushar.n.dave@oracle.com>
> Date: Tue, 11 Jul 2017 20:43:39 -0700
> 
>> Yes, indeed the bug is in Linus's tree. However, 'sparc' tree doesn't
>> have DMA API change (e.g. commit b02c2b0bfd7ae) yet that introduced
>> the panic.
> 
> You can simply make a note of this when you send the bug fix to me.:( yeah, I should have mentioned this when I sent patch to you. My bad.
Will make sure to left you a note for this kid of occurrence in future!

-Tushar
> 
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
