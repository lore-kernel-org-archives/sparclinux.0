From: BERTRAND Joel <joel.bertrand@systella.fr>
Date: Sun, 01 Nov 2009 18:09:31 +0000
Subject: Re: temperature & fan-control
Message-Id: <4AEDCEDB.4010701@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <1256288818.1858.15.camel@deblnxsrv254.opensoftwarenetwork.nl>
In-Reply-To: <1256288818.1858.15.camel@deblnxsrv254.opensoftwarenetwork.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Frans van Berckel wrote:
>> 	Hello,
>>
>> 	2.6.27 is the last usable kernel on Blade 2000. I run a 2.6.28.10 with =

>> some patches and env_bbc is initialized. Module can be unloaded without =

>> Oops, but no information is read.
>>
>> 	I have disabled bbc on all my Blades because bbc module (2.6.27)=20
>> randomly returns very strange values (more than 85 =C2=B0C) and workstat=
ion=20
>> switches off. It can happen when these workstations do not run anything.=
=20
>> These workstations are clean and run without any trouble with Solaris.
>>
>> 	When bbc returns an overheating event, fan speed is not set to its=20
>> maximum value. I have try to debug without any success because I cannot =

>> reproduce it.
>>
>> 	Regards,
>>
>> 	JKB
>=20
> Talking about env_bbc the Have you seen how the max1617 i2c devices are
> supported in Open Solaris?

	I have never installed OpenSolaris on these workstations, only Solaris 10.

	JKB
