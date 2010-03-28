From: Julia Lawall <julia@diku.dk>
Date: Sun, 28 Mar 2010 15:40:23 +0000
Subject: question about drivers/serial/sunsu.c
Message-Id: <Pine.LNX.4.64.1003281737590.29824@ask.diku.dk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The function su_probe in the file drivers/serial/sunsu.c contains the 
code:

	if (up->su_type = SU_PORT_KBD || up->su_type = SU_PORT_MS) {
		err = sunsu_kbd_ms_init(up);
	        if (err) {
                        kfree(up);
                        goto out_unmap;
		}
                dev_set_drvdata(&op->dev, up);

		return 0;
	}

And then the label out_unmap contains:

out_unmap:
	of_iounmap(&op->resource[0], up->port.membase, up->reg_size);
	return err;

which represents a potential use of up after the free.  There are however 
other gotos to out_unmap that don't seem to want to free up.  Should the 
of_iounmap just be copied up before the kfree(up)?

julia
