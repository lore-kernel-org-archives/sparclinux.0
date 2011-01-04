From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 04 Jan 2011 14:42:45 +0000
Subject: Re: [RFC 1/8] sparc: prom: Sanitize return value from prom_nbputchar()
Message-Id: <4D2331E5.7050608@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4CF9BBC6.3080809@julian.is-a-geek.org>
In-Reply-To: <4CF9BBC6.3080809@julian.is-a-geek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Julian Calaby <jcalaby@julian.is-a-geek.org>
>Date: Sat, 04 Dec 2010 14:55:50 +1100
>
>  
>
>>Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
>>    
>>
>
>Applied.
>  
>

I think this patch breaks the backwards compatability... Before this 
patch one had to return -1 from prom-code in order to implement a 
non-locking nbputchar() in PROM code (see old code below). With the new 
patch however one has to return a 0 and -1 is now interpreted as send 
successful.

Should we not check for values bigger than 0 so that -1 can be return by 
old PROMs? I suggest:

-		i = (*(romvec->pv_nbputchar))(*buf);
+		if ((*(romvec->pv_nbputchar))(*buf) > 0)
+			i = 1;


Regards,
Daniel


The applied patch:

-		i = (*(romvec->pv_nbputchar))(*buf);
+		if ((*(romvec->pv_nbputchar))(*buf))
+			i = 1;


Old version of nbputchar():

/* Non blocking put character to console device, returns -1 if
 * unsuccessful.
 */
int
prom_nbputchar(char c)
{
	static char outc;
	unsigned long flags;
	int i = -1;

	spin_lock_irqsave(&prom_lock, flags);
	switch(prom_vers) {
	case PROM_V0:
		i = (*(romvec->pv_nbputchar))(c);
		break;
	case PROM_V2:
	case PROM_V3:
		outc = c;
		if( (*(romvec->pv_v2devops).v2_dev_write)(*romvec->pv_v2bootargs.fd_stdout, &outc, 0x1) = 1)
			i = 0;
		else
			i = -1;
		break;
	default:
		i = -1;
		break;
	};
	restore_current();
	spin_unlock_irqrestore(&prom_lock, flags);
	return i; /* Ugh, we could spin forever on unsupported proms ;( */
}

/* Blocking version of put character routine above. */
void
prom_putchar(char c)
{
	while(prom_nbputchar(c) = -1) ;
}


