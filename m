From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Fri, 18 Feb 2005 08:19:08 +0000
Subject: RE: size-differences of long(userspace) / long(kernel)
Message-Id: <DA6197CAE190A847B662079EF7631C060E8D25@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
In-Reply-To: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dear listmembers,
took me some time to come back into track. According to Dave one could replace 

in arch/sparc64/kernel/sys_sparc32.c:
asmlinkage int sys32_get_kernel_syms(struct kernel_sym32 *table)
{
        int len, i;
        struct kernel_sym *tbl;
        mm_segment_t old_fs;   
 
        len = sys_get_kernel_syms(NULL);
        if (!table) return len;
        tbl = kmalloc (len * sizeof (struct kernel_sym), GFP_KERNEL);
		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

by:

        if (!table) return len;
        tbl = compat_alloc_user_space (len * sizeof (strict kernel_sym));


or ist there a caveat because I do not specify GFP_KERNEL to allow sleeping for that?
Many thanks for any inputs,
take care


Dieter Jurzitza

-----Original Message-----
From: sparclinux-owner@vger.kernel.org
[mailto:sparclinux-owner@vger.kernel.org]On Behalf Of David S. Miller
Sent: Monday, February 14, 2005 5:44 PM
To: Jurzitza, Dieter
Cc: sparclinux@vger.kernel.org
Subject: Re: size-differences of long(userspace) / long(kernel)

******
We don't use kmalloc() always, in fact most often we use alloc_user_space()
(named compat_alloc_user_space()) so that the limits are the same.
******


*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich erhalten haben, informieren Sie bitte sofort den Absender und loeschen Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
 
This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and delete this e-mail. Any unauthorized copying, disclosure or distribution of the contents in this e-mail is strictly forbidden.
*******************************************

