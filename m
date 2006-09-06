From: Daniel Smolik <marvin@mydatex.cz>
Date: Wed, 06 Sep 2006 20:32:04 +0000
Subject: openpromfs 2.6.18-rc6
Message-Id: <44FF3044.2020509@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I want change my input-device from keyboard to rsc and I get invalid argument.

echo 'rsc' > /proc/openprom/options/input-device. eeprom ends with SIGBUS.
Under 2.6.17.2 openpromfs works well.


			Regards
				Dan
