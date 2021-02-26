From: Meelis Roos <mroos@linux.ee>
Date: Fri, 26 Feb 2021 15:57:38 +0000
Subject: Re: bisected kernel crash on sparc64 with stress-ng
Message-Id: <b7316a52-482f-3710-4111-d5f36703e4e7@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
In-Reply-To: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

>> From two boots, the insn varies among
>> c798d0c9
>> c8c6d0de
>> cf95d1ef
>> d49cd066
>> dad750ec
>> e09810de
>> e3e790c4
>> e5a051cb
>> e7f21165
>> ea8fd1cb
>> ebb611fc
>> f4c551de
>> fe8690fd
>> fff21079
>=20
>=20
> Are you saying that in this list of instructions, each one of them causes=
 a crash or hang?

No, these just appear in dmesg, most of them do not seem to cause a crash b=
ecause I did not have so many boots.My dmesg capture is unfortunately flaky=
 with MikroTik SSH jumphost or Sun ALOM dropping the SSH console connection=
 often.


>>> which should assemble to 0xc1a01040. You could just try this instructio=
n.

All tests after that start with this instruction and continue with random o=
nes - I just overwite the start of opcode buffer with this.
>>> 4. If this does result in a crash, this patch might be the fix:
>>
>> Yes, with this patch only, it works for multiple minutes and is stable. =
Nothing in dmesg either.
>>
>>> 5. Here is another patch to try after the others:
>>
>>
>> This resulted in a crash (this is different, irq5 during mm code):
>>
>> [=C2=A0 304.847868] Unable to handle kernel paging request at virtual ad=
dress ffffffffffffe000
>=20
>=20
> But what was the last "fixing up no fault insn" message you got before th=
is panic? I need that to be sure that this is just another instance of the =
other panics and not a different cause.

Did not manage to capture this. Since this was the later kernel, I have it =
still around and retested - there was no "fixing up ..." message befor the =
crash (probably).

>=20
> Also, did you apply this code patch along with others or was it alone? If=
 alone, please try running with all 3 patches applied. My logic leads me to=
 believe that you should not see any panics/hangs with all the code changes=
 applied.

OK, will try them together - I did try one by one so far and applied some (=
at least one) by hand but I think successfully - might have failed because =
I applied it to the wrong state of code.

 =20
> I think the important test cases are c1a01040 (which should be fixed by t=
he first code patch) and cf95d1ef, (which should be fixed by the second cod=
e patch.)


Will try the patches incrementally and with both constants for overwriting =
the start of the opcode block.

--=20
Meelis Roos <mroos@linux.ee>
