From: Marc Zyngier <maz@misterjones.org>
Date: Mon, 17 Jul 2006 13:14:10 +0000
Subject: Re: 2.6.18-rc1 fails to boot on E250
Message-Id: <wrpirlwcr19.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060714.165308.83620688.davem@davemloft.net>
In-Reply-To: <20060714.165308.83620688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "maz" = Marc Zyngier <maz@misterjones.org> writes:

maz> Would have to swap between 0x1fff1400000 and 0x1fff1400040. I'll try
maz> to come up with a patch if I can spare some time tonight.

I tried the following patch, without much success.  Looks like
*nothing* hits the serial console if '-p' isn't set on the command
line. I still suspect that this patch is valid though. Oh well...

Off to some more head scratching.

	M.

[SPARC64] Fix sunsab ports ordering

Register second SAB port before the first one, as serial A is wired to
it, and expected to appear as ttyS0.

Signed-off-by: Marc Zyngier <maz@misterjones.org>

diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index 979497f..cb55d81 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -1061,8 +1061,8 @@ static int __devinit sab_probe(struct of
 		return err;
 	}
 
-	uart_add_one_port(&sunsab_reg, &up[0].port);
 	uart_add_one_port(&sunsab_reg, &up[1].port);
+	uart_add_one_port(&sunsab_reg, &up[0].port);
 
 	dev_set_drvdata(&op->dev, &up[0]);
 

-- 
And if you don't know where you're going, any road will take you there...
