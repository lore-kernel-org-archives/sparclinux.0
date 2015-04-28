From: Eric Snowberg <eric.snowberg@oracle.com>
Date: Tue, 28 Apr 2015 16:12:32 +0000
Subject: Re: [PATCH RFC 1/1] sparc64: pci slots information is not populated in sysfs
Message-Id: <B8DC91F1-2F9A-417C-A005-13BF63B16FA2@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1430172435-231374-1-git-send-email-eric.snowberg@oracle.com>
In-Reply-To: <1430172435-231374-1-git-send-email-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


> On Apr 28, 2015, at 4:49 AM, Julian Calaby <julian.calaby@gmail.com> wrot=
e:
>=20
> One last thing: would it be worth it to put the following before the
> while loop instead of having the test inside it? I dislike invariant
> tests in loops. (Incremental patch attached)
>=20
> +        if (tlb_type =3D hypervisor) {
> +                while ((pbus =3D pci_find_next_bus(pbus)) !=3D NULL)
> +                        pci_sun4v_bus_slot_names(pbus);
> +
> +                return 0;
> +        }

That make sense, I=E2=80=99ll update the patch with this change.

Thanks,
-Eric

