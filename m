From: Matthias Schulz <schulz@sms-softwaretechnik.de>
Date: Wed, 25 Aug 2004 15:46:27 +0000
Subject: Re: future of drivers/fc4/
Message-Id: <412CB453.2050504@sms-softwaretechnik.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I saw your posts on vger.kernel.org but it doesn't seem to find a lot of 
reaction there.

I do have a lot of hardware to test this (S1000E, SSA 100, E5000, 
A5000). A while back, I had the 2.2.20 kernel running with my SS1000E 
and the SSA 100 attached. Worked fine. But any version of Linux later 
than 2.2.20 didn't do it.

Could it be, that the mayjor changes from 2.2 -> 2.4 (SMP, scsi etc.) 
are the REAL reason for that ?

I don't think it has to do woth hardware issues other than having the 
right firmwar on either the soc-board (1.33) and the SSA (3.??).

Did you get any further ?

Did you have it running with 2.2.??

Sincerly,
Matthias Schulz

C.Newport schrieb:
> On Sunday 20 June 2004 7:40 pm, David S. Miller wrote:
> 
>>On Sun, 20 Jun 2004 18:03:53 +0200
>>
>>Christoph Hellwig <hch@lst.de> wrote:
>>
>>>The SUN FCAL support has been non-working for ages and needs major work
>>>to keep up with scsi API changes.  Is anyone planning to ressurect it
>>>midterm?  If not I'd like to remove it from the tree.
>>
>>Feel free to remove it, interested parties can resurrect the source
>>really easily.
> 
> 
> If it is that easy could someone tell me what needs doing please ?
> I am NOT a kernel programmer but given a little handholding and
> a list of what to do I can build and test it here.
> 
> I also have a spare set of hardware if someone in the UK with the
> needed skills would like it. Sorry, but the disk array is a bit heavy to 
> ship elsewhere. If someone already has the array I will mail a card
> anywhere.
> 
> We need this if we are ever to get the Sun4D working again.
> Keith now has a contact for the missing info to get Sun4D working
> properly, but without the fc, soc and pluto it will be rather restricted in
> usefulness.
> 
>  
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

