From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 12 Apr 2006 02:47:21 +0000
Subject: Re: Issues with SILO 1.4.11
Message-Id: <Pine.LNX.4.63.0604111937370.3716@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.63.0604101839350.3168@bobcat>
In-Reply-To: <Pine.LNX.4.63.0604101839350.3168@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 11 Apr 2006, David S. Miller wrote:
> From: Frans Pop <aragorn@tiscali.nl>
>> On Tuesday 11 April 2006 23:21, David S. Miller wrote:
>>> You cannot write to the %tick register on some cpu variants,
>>> it can only be written by the hypervisor.
>>
>> Is it possible to test for that capability being present?
>
> Not easily but yes, but the old code was buggy in other regards as
> well.  It would need to be rewritten.

Hi Dave,

From what I can tell, the only thing which removed code in second/timer.c 
did is a) store the current value of the tick_cmpr register in the 
sun4u_tickcmpr variable and disable interrupts from tick_cmpr by setting 
bit 63 in it in sun4u_init_timer(); and b) restore the tick_cmpr value 
from the variable in close_timer(). Could you explain how the removal of 
this code could lead to the dramatic effect if timeout not being honoured? 
tick_cmpr register is not touched elsewhere in the code, and I would 
naively think that it should still work on *any* machine which has a tick 
register (which Ultra10 obviously has). Any pointers to documentation 
would be greatly appreciated.

Thanks,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
