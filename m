From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Mon, 14 Feb 2005 16:32:07 +0000
Subject: RE: size-differences of long(userspace) / long(kernel)
Message-Id: <DA6197CAE190A847B662079EF7631C060E8CF3@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
In-Reply-To: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi folks,
nevertheless we may run into space issues because structures may grow on their way from userland to kernel-country, thereby kmalloc() calls are subject to earlier failures, as the maximum size of allocable memory for kmalloc() remains the same.

See i. e. linux/include/linux/module.h, what is (harmlessly here ...) used by get_kernel_syms.


Take care



Dieter Jurzitza

-----Original Message-----
From: sparclinux-owner@vger.kernel.org
[mailto:sparclinux-owner@vger.kernel.org]On Behalf Of David S. Miller
Sent: Monday, February 14, 2005 5:13 PM
To: Michael Tautschnig
Cc: sparclinux@vger.kernel.org
Subject: Re: size-differences of long(userspace) / long(kernel)



See arch/sparc64/kernel/ioctl32.c, we translate all of the
structures on the way in and out of userspace when 64-bit
kernel runs 32-bit applications.
-
To unsubscribe from this list: send the line "unsubscribe sparclinux" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich erhalten haben, informieren Sie bitte sofort den Absender und loeschen Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
 
This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and delete this e-mail. Any unauthorized copying, disclosure or distribution of the contents in this e-mail is strictly forbidden.
*******************************************

