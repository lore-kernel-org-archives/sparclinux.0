From: Chris Ricker <kaboom@gatech.edu>
Date: Tue, 27 Jul 2004 14:27:28 +0000
Subject: slab corruption and stuck CPU under 2.6.8rc2
Message-Id: <Pine.GSO.4.58.0407271017560.14292@redfish.gatech.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040727133947.GA12350@phunnypharm.org>
In-Reply-To: <20040727133947.GA12350@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

I'm getting the following:

Jul 26 06:25:34 scratchmonkey kernel: Slab corruption: start=FFfff80038fd4a=
80, len=168
Jul 26 06:25:34 scratchmonkey kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b=
 6b 6b 6b 6b 6b
Jul 26 06:25:34 scratchmonkey kernel: Prev obj: start=FFfff80038fd49d8, len=
=168
Jul 26 06:25:34 scratchmonkey kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b=
 6b 6b 6b 6b 6b
Jul 26 06:25:34 scratchmonkey kernel: 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b=
 6b 6b 6b 6b 6b
Jul 26 06:25:34 scratchmonkey kernel: Next obj: start=FFfff80038fd4b28, len=
=168
Jul 26 06:25:34 scratchmonkey kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b=
 6b 6b 6b 6b 6b
Jul 26 06:25:34 scratchmonkey kernel: 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b=
 6b 6b 6b 6b 6b
Jul 27 09:18:44 scratchmonkey kernel: Slab corruption: start=FFfff8002fda0a=
80, len=168
Jul 27 09:18:44 scratchmonkey kernel: read_lock(00000000006fde40) CPU#0 stu=
ck at 0045ae18, writer PC(00451808):CPU(2)
Jul 27 09:18:44 scratchmonkey kernel: read_lock(00000000006fde40) CPU#0 stu=
ck at 0045ae18, writer PC(00451808):CPU(2)
Jul 27 09:18:44 scratchmonkey kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b=
 6b 6b 6b 6b 6b
Jul 27 09:18:44 scratchmonkey kernel: Prev obj: start=FFfff8002fda09d8, len=
=168
Jul 27 09:18:44 scratchmonkey kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b=
 6b 6b 6b 6b 6b
Jul 27 09:18:44 scratchmonkey kernel: 010: 6b 6b 6b 6b 6b 6b 6bread_lock(00=
000000006fde40) CPU#0 stuck at 0045ae18, writer PC(00451808):CPU(2)
Jul 27 09:18:44 scratchmonkey kernel:  6b 6b 6b 6b 6b 6b 6b 6b 6b
Jul 27 09:18:44 scratchmonkey kernel: Next obj: start=FFfff8002fda0b28, len=
=168
Jul 27 09:18:44 scratchmonkey kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b=
 6b 6b 6b 6b 6b
Jul 27 09:18:44 scratchmonkey kernel: 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b=
 6b 6b 6b 6b 6b

in my logs

Hardware problem or software?

This is on an Ultra 60, 2 300 MHz CPUs, Symbios 53c875 SCSI card, qfe=20
ethernet, low-end Sun video (ATI Rage XL-based)

thanks,
chris
