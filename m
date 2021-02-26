From: Meelis Roos <mroos@linux.ee>
Date: Fri, 26 Feb 2021 18:03:41 +0000
Subject: Re: bisected kernel crash on sparc64 with stress-ng
Message-Id: <ede51bdb-6746-93d8-7f4b-8620c2105d81@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
In-Reply-To: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


>> This resulted in a crash (this is different, irq5 during mm code):
>>
>> [=C2=A0 304.847868] Unable to handle kernel paging request at virtual ad=
dress ffffffffffffe000
>=20
>=20
> But what was the last "fixing up no fault insn" message you got before th=
is panic? I need that to be sure that this is just another instance of the =
other panics and not a different cause.


Rechecked with the same kernel image of last patch only, this time the faul=
t address is different, but still no previous debug messages (probably expe=
cted since no previous patches are there),
just starts with
Unable to handle kernel paging request at virtual address 256c780a00000000
And the rest of addresses and backtrace is also different.

> Also, did you apply this code patch along with others or was it alone? If=
 alone, please try running with all 3 patches applied. My logic leads me to=
 believe that you should not see any panics/hangs with all the code changes=
 applied.

I hope to have the SSH console connection in better shape now (no mikrotik =
jumphost on the way), will start retesting with incremental patches.

--=20
Meelis Roos <mroos@linux.ee>
