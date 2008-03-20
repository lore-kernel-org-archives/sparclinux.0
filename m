From: Roel Kluin <12o3l@tiscali.nl>
Date: Thu, 20 Mar 2008 17:09:53 +0000
Subject: sound/sparc/dbri.c: snd_dbri_pcm(): strcpy(pcm->name, card->shortname)?
Message-Id: <47E29A61.40008@tiscali.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

from sound/sparc/dbri.c:2233:

strcpy(pcm->name, card->shortname);

shouldn't that be 'strcpy(card->shortname, pcm->name)'?
