Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955713EF643;
	Wed, 14 Oct 2026 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008093; cv=none; b=iPssJzUuejDDPSvS+d8bFJGu5PW08mTq/Lv2JdgY2X6z3wRwDrE5W2H6vzc3W0pEUyWSOd1NiJYkfqJW+uxwj0tf1f8ct8buF478/e/wB0C4e7OnEhTC5Tlz+f9KdHIRyF7KJTVrsfrTtfBydbTNgNd9DwKz8FqF923A2C8p984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008093; c=relaxed/simple;
	bh=RTUsSg4hhQPc38/w1iz3yzoGFQVaMkd6UXlpt7tdK98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWoXTNXlIrpDUxjYgKjlQIcIxKYQRhs2Tu0Ui710n3LmHerswoVRfTR9ZXTrKjimz6L1XhPVsDfHkuuETqemf+hkJ//VbV+NGrFbrVBjDWe5JMW+DI1EQHjNyEKFeYhp0I7ypQYVpJFaWpBhvfP7PJH3tILb1nqvX5z5gl++sHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSxhzYXi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSxhzYXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A1D1F000C4;
	Wed, 14 Oct 2026 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008087;
	bh=c+ft7M9gKgyjjxQdn8nKo6ADdoM0gUbB/WYH4VwDknE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QSxhzYXiJ8N4EcMGFQRsasGL8rUlTSLqzBc78SADl01gOa5QzhdVa7V7GV/bfg2Lf
	 egxxD6KobgHB5B+FNeTvAHKQlB+LCYvCdOmDnus8wi6zqcqRI8H/Iabfzn3tOqhcQs
	 zow53yeJ9fLA+eyRj2ukSxeSmrCsTWDhErvTiTxNrighrTUGkSvIjDSho41KzRfigK
	 s6ATXAbVUyRQqHlgsSbGBaQV8LSl5vsaNhGaFl01LjkpSjN/q7wRmMCGJAhLDVGB5L
	 G4Zarc1O/MJHaGv0gTBUc6vvHzuEC672Da8LwxYIE27TIcXOGg6B7hRnMdpd9pkGcx
	 nYt4hb6edfJxA==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] selftests/sparc64: report failures of the drivers subdirectory
Date: Wed, 14 Oct 2026 16:01:15 -0400
Message-ID: <20261014200115.1363363-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014200115.1363363-1-sashal@kernel.org>
References: <20261014200115.1363363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sparc64 suite builds and installs its subdirectories in shell loops
whose status is that of the last command. For the build that is the
copy of the subdirectory's test script, so "make all" succeeds even
when the drivers tests fail to compile, and FORCE_TARGETS has no effect.

Fold the copy into the status of the subdirectory and let both loops
return failure when no subdirectory succeeds, which matches how the
top-level selftests Makefile treats its targets, or as soon as one fails
when FORCE_TARGETS is set. When a build report is requested, record
each subdirectory as sparc64/<subdir>. Invoke the subdirectories with
$(MAKE) so that they use the parent's jobserver.

Fixes: 3c545084130c ("selftests: sparc64: char: Selftest for privileged ADI driver")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/sparc64/Makefile | 33 ++++++++++++++++--------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/sparc64/Makefile b/tools/testing/selftests/sparc64/Makefile
index 88f7be76f962d..a979c819348a0 100644
--- a/tools/testing/selftests/sparc64/Makefile
+++ b/tools/testing/selftests/sparc64/Makefile
@@ -2,6 +2,8 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 override ARCH := $(shell echo $(ARCH) | sed -e s/x86_64/x86/)
 
+include ../build_report.mk
+
 ifneq ($(ARCH),sparc64)
 nothing:
 .PHONY: all clean run_tests install
@@ -18,33 +20,42 @@ TEST_PROGS := run.sh
 include ../lib.mk
 
 all:
-	@for DIR in $(SUBDIRS); do		\
-		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
-		mkdir $$BUILD_TARGET  -p;	\
-		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
+	@ret=$(if $(SUBDIRS),1,0); for DIR in $(SUBDIRS); do	\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		mkdir -p $$BUILD_TARGET &&			\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;	\
+		status=$$?;					\
 		#SUBDIR test prog name should be in the form: SUBDIR_test.sh \
 		TEST=$$DIR"_test.sh"; \
 		if [ -e $$DIR/$$TEST ]; then \
-			rsync -a $$DIR/$$TEST $$BUILD_TARGET/; \
-		fi \
-	done
+			rsync -a $$DIR/$$TEST $$BUILD_TARGET/ || \
+				[ $$status -ne 0 ] || status=1;	\
+		fi; \
+		$(call ksft_record_build_status,all,sparc64/$$DIR); \
+		$(if $(FORCE_TARGETS),[ $$status -eq 0 ] || exit $$status;) \
+		[ $$status -eq 0 ] && ret=0;			\
+	done; exit $$ret
 
 override define INSTALL_RULE
 	mkdir -p $(INSTALL_PATH)
 	install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)
 
-	@for SUBDIR in $(SUBDIRS); do \
+	@ret=$(if $(SUBDIRS),1,0); for SUBDIR in $(SUBDIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$SUBDIR;	\
-		mkdir $$BUILD_TARGET  -p;	\
+		mkdir -p $$BUILD_TARGET &&		\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$SUBDIR INSTALL_PATH=$(INSTALL_PATH)/$$SUBDIR install; \
-	done;
+		status=$$?;				\
+		$(call ksft_record_build_status,install,sparc64/$$SUBDIR); \
+		$(if $(FORCE_TARGETS),[ $$status -eq 0 ] || exit $$status;) \
+		[ $$status -eq 0 ] && ret=0;		\
+	done; exit $$ret
 endef
 
 override define CLEAN
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
-		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
 	done
 endef
 endif
-- 
2.53.0

