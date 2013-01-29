From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 29 Jan 2013 14:25:55 +0000
Subject: Re: [PATCH v5 16/20] scripts/gdb: Add internal helper and convenience function for per-cpu lookup
Message-Id: <5107DBF3.6000802@siemens.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1359463075.git.jan.kiszka@siemens.com> <04960fa208fbd9c0962eb4f70aa45d28aec59e8d.1359463075.git.jan.kiszka@siemens.com> <20130129135109.GF14302@pd.tnic> <5107D528.2010305@siemens.com> <20130129141202.GH14302@pd.tnic>
In-Reply-To: <20130129141202.GH14302@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>, Tom Tromey <tromey@redhat.com>, Ben Widawsky <ben@bwidawsk.net>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On 2013-01-29 15:12, Borislav Petkov wrote:
> On Tue, Jan 29, 2013 at 02:56:56PM +0100, Jan Kiszka wrote:
>> Let me guess: You are dumping a weird QEMU/KVM CPU, right?
>=20
> Nah, I actually have the silicon! :-)
>=20
> Joking, of course. I wish. I'm booting the guest with -cpu phenom (it
> has been like that since forever in my boot-kernel-in-kvm script) but
> the host is Intel.
>=20
> If I do this on an AMD host, all is ok:
>=20
> (gdb) p $lx_per_cpu("cpu_info").x86_vendor_id
> $1 =3D "AuthenticAMD\000\000\000"
> (gdb) p $lx_per_cpu("cpu_info").x86_model_id
> $2 =3D "AMD Phenom(tm) 9550 Quad-Core Processor", '\000' <repeats 24 time=
s>
> (gdb)

Remains a bug of QEMU, though possibly a minor one.

>=20
> [ =E2=80=A6 ]
>=20
>>>> +class PerCpu(gdb.Function):
>>>> +	__doc__ =3D "Return per-cpu variable.\n" \
>>>> +		  "\n" \
>>>> +		  "$lx_per_cpu(\"VAR\"[, CPU]): Return the per-cpu variable called =
VAR for the\n" \
>>>> +		  "given CPU number. If CPU is omitted, the CPU of the current cont=
ext is used.\n" \
>>>> +		  "Note that VAR has to be quoted as string."
>>>
>>>
>>> Ok, seriously now:
>>>
>>> apropos shows the "Return per-cpu... " line above. Have you found out
>>> which gdb command shows the rest? help and info both say "Undefined
>>> command".
>>
>> help function lx_...
>>
>> It took me a while to find this, too.
>=20
> Maybe worth documenting it then at the end of gdb-kernel-debugging.txt?
>=20

Done. Will come with v6 (if needed), otherwise as an add-on patch.

Thanks,
Jan

--=20
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux
