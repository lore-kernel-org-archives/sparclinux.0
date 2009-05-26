From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 26 May 2009 08:48:09 +0000
Subject: Re: [bbc_i2c] howto read CPU temp ?
Message-Id: <4A1BACC9.2010409@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1BA00E.9070204@systella.fr>
In-Reply-To: <4A1BA00E.9070204@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: BERTRAND Jo=EBl <joel.bertrand@systella.fr>
> Date: Tue, 26 May 2009 09:53:50 +0200
>=20
>=20
>>	I have reduced maximal CPU frequencies, but I want to use cpufreqd (or
>>	some other script to modify cpu governor). I don't see where kernel
>>	writes CPU temperature ? I find anything in /sys or /proc. How can I
>>	obtain this temp ?
>=20
>=20
> This information is not exported.  There was a patch to add this
> and adjust some of the heuristics in the driver but the patch
> was very poorly written.
>=20
> The existing module adjusts the CPU and system fan speeds dynamically
> in response to temperature, and will shutdown the system if the
> temperature gets over a certain max threshold.

	Thanks a lot for your answer. I shall add a /proc/bbc_i2c that only=20
exports CPU, ambiant values and fan speed.

	Regards,

	JKB
