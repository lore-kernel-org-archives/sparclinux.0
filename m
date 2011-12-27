From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 27 Dec 2011 21:22:53 +0000
Subject: [PATCH 1/1] apbuart: fix section mismatch warning
Message-Id: <20111227212253.GA8161@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From b82ccce349dee62fe5acd3167a19490bbe9a7e18 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 27 Dec 2011 22:07:23 +0100
Subject: [PATCH] apbuart: fix section mismatch warning

Fix following warnings:

WARNING: drivers/tty/serial/built-in.o(.text+0x7370): Section mismatch in reference from the function grlib_apbuart_configure() to the variable .init.data:apbuart_match
The function grlib_apbuart_configure() references
the variable __initdata apbuart_match.
This is often because grlib_apbuart_configure lacks a __initdata
annotation or the annotation of apbuart_match is wrong.

+ 3 more warnings like this.

There is no guarantee that grlib_apbuart_of_driver.of_match_table
is only used at __init time - so drop the __initdata annotation.

grlib_apbuart_configure() is only used during __init so add __init
to this method too.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/apbuart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 77554fd..7162f70 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -577,7 +577,7 @@ static int __devinit apbuart_probe(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id __initdata apbuart_match[] = {
+static struct of_device_id apbuart_match[] = {
 	{
 	 .name = "GAISLER_APBUART",
 	 },
@@ -597,7 +597,7 @@ static struct platform_driver grlib_apbuart_of_driver = {
 };
 
 
-static int grlib_apbuart_configure(void)
+static int __init grlib_apbuart_configure(void)
 {
 	struct device_node *np;
 	int line = 0;
-- 
1.6.0.6

