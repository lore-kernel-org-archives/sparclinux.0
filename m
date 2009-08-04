From: Eldar Abusalimov <eldar.abusalimov@gmail.com>
Date: Tue, 04 Aug 2009 09:41:02 +0000
Subject: Re: Is it a bug in etrap.S srmmu stack check routine?
Message-Id: <d543c060908040241q6e4400a6n167301a5ac849b79@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <d543c060908031036k66ebd6a5h5285dabf3f5aefe3@mail.gmail.com>
In-Reply-To: <d543c060908031036k66ebd6a5h5285dabf3f5aefe3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Forwarding it here.


---------- Forwarded message ----------
From: Eldar Abusalimov <eldar.abusalimov@gmail.com>
Date: 2009/8/4
Subject: Re: Is it a bug in etrap.S srmmu stack check routine?
To: David Miller <davem@davemloft.net>


2009/8/4 David Miller <davem@davemloft.net>:
> From: Eldar Abusalimov <eldar.abusalimov@gmail.com>
> Date: Mon, 3 Aug 2009 21:36:31 +0400
>
>> Hi, David!
>>
>> I've been looking into traps-related routines for some time, and was
>> confused with srmmu user stack checking code.
>>
>> Here is the corresponding part of etrap.S file:
>>
>> 278 =A0 =A0 =A0 =A0 =A0 .globl =A0tsetup_srmmu_stackchk
>> 279 =A0 tsetup_srmmu_stackchk:
>> 280 =A0 =A0 =A0 =A0 =A0 /* Check results of callers andcc %sp, 0x7, %g0 =
*/
>> 281 =A0 =A0 =A0 =A0 =A0 bne =A0 =A0 trap_setup_user_stack_is_bolixed
>> 282 =A0 =A0 =A0 =A0 =A0 =A0sethi =A0 %hi(PAGE_OFFSET), %glob_tmp
>> 283
>> 284 =A0 =A0 =A0 =A0 =A0 cmp =A0 =A0 %glob_tmp, %sp
>> 285 =A0 =A0 =A0 =A0 =A0 bleu,a =A01f
>> 286 =A0 =A0 =A0 =A0 =A0 =A0lda =A0 =A0[%g0] ASI_M_MMUREGS, %glob_tmp =A0=
 =A0 =A0 =A0 =A0! read MMU control
>> 287
>> 288 =A0 trap_setup_user_stack_is_bolixed:
>> 289 =A0 =A0 =A0 =A0 =A0 /* From user/kernel into invalid window w/bad us=
er
>> 290 =A0 =A0 =A0 =A0 =A0 =A0* stack. Save bad user stack, and return to c=
aller.
>> 291 =A0 =A0 =A0 =A0 =A0 =A0*/
>> 292 =A0 =A0 =A0 =A0 =A0 SAVE_BOLIXED_USER_STACK(curptr, g3)
>> 293 =A0 =A0 =A0 =A0 =A0 restore %g0, %g0, %g0
>> 294
>> 295 =A0 =A0 =A0 =A0 =A0 jmpl =A0 =A0%t_retpc + 0x8, %g0
>> 296 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0%t_kstack, %sp
>> 297
>> 298 =A0 1:
>> 299 =A0 =A0 =A0 =A0 =A0 /* Clear the fault status and turn on the no_fau=
lt bit. */
>> 300 =A0 =A0 =A0 =A0 =A0 or =A0 =A0 =A0%glob_tmp, 0x2, %glob_tmp =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 ! or in
>> no_fault bit
>> 301 =A0 =A0 =A0 =A0 =A0 sta =A0 =A0 %glob_tmp, [%g0] ASI_M_MMUREGS =A0 =
=A0 =A0 =A0 =A0! set it
>> 302
>> 303 =A0 =A0 =A0 =A0 =A0 /* Dump the registers and cross fingers. */
>> 304 =A0 =A0 =A0 =A0 =A0 STORE_WINDOW(sp)
>>
>> On the line 284 we compare user stack pointer with PAGE_OFFSET, and if
>> it is greater than PAGE_OFFSET, then we consider user stack is still
>> ok and continue checking. On the contrary, if %sp is small enough,
>> bollixed stack handler is entered at once. Is it right?
>
> We want to fall through to line 288 if PAGE_OFFSET > %sp and that's
> what we do.
>

Thank you for the reply.

That is PAGE_OFFSET > %sp means a corrupt user stack condition, isn't
it? Then why we do the same check in wof.S (see my first post), but
the stack is considered to be corrupt under the opposite condition
(when PAGE_OFFSET <=3D %sp)? What's the difference between these two
cases?

My questions may look silly, but I still have not understood what's
wrong in my chain of reasoning. =3D)

--
Best regards,
Eldar Sh. Abusalimov



--=20
Best regards,
Eldar Sh. Abusalimov
