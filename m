From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Wed, 09 Feb 2005 06:04:22 +0000
Subject: RE: Hang in SIOCGIFCONF ioctl handler
Message-Id: <DA6197CAE190A847B662079EF7631C060E8CAF@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502071259370.2050@bobcat>
In-Reply-To: <Pine.LNX.4.61.0502071259370.2050@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dear listmembers,
seing the communication between Jurij and Dave I took a glance into the 2.4.29 - tree and found the identical code segment as discussed below. This tells me that 2.4.X is supposed to suffer from the same issues as you tracked down for 2.6.X, isn't it? However, what I did not find is include/asm-sparc64/compat.h; this made me wonder whether I should expect a basic difference here, but maybe I simply misunderstood.
Thanks,
take care



Dieter Jurzitza

-----Original Message-----
From: sparclinux-owner@vger.kernel.org
[mailto:sparclinux-owner@vger.kernel.org]On Behalf Of David S. Miller
Sent: Monday, February 07, 2005 8:58 PM
To: jurij@wooyd.org
Cc: sparclinux@vger.kernel.org
Subject: Re: Hang in SIOCGIFCONF ioctl handler


On Mon, 7 Feb 2005 13:21:16 -0500 (EST)
Jurij Smakov <jurij@wooyd.org> wrote:

> On an unrelated note, during my exploration I came across the function 
> copy_in_user_fixup in arch/sparc64/lib/user_fixup.c. In this function (and 
> in other functions in that file) copying is done using a loop like this:
> 
>    while(size--) {
****


*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich erhalten haben, informieren Sie bitte sofort den Absender und loeschen Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
 
This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and delete this e-mail. Any unauthorized copying, disclosure or distribution of the contents in this e-mail is strictly forbidden.
*******************************************

