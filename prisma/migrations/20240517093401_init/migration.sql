-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMINISTRATOR', 'CLIENT', 'DEPARTMENT_HEAD', 'HR', 'MANAGER', 'MARKETER', 'SALES_ASSISTANT');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role"[],
    "position" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "client_type" TEXT NOT NULL,
    "notification_sms" BOOLEAN NOT NULL,
    "notification_email" BOOLEAN NOT NULL,
    "industries" TEXT[],

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Company" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "inn" TEXT NOT NULL,
    "federal_district" TEXT NOT NULL,
    "contract_number" TEXT NOT NULL,
    "legal_address" TEXT NOT NULL,
    "industries" TEXT[],
    "mail_address" TEXT NOT NULL,
    "test_period" TEXT NOT NULL,
    "contract_start" TEXT NOT NULL,
    "contract_end" TEXT NOT NULL,
    "connect_start" TEXT NOT NULL,
    "connect_end" TEXT NOT NULL,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User_activity" (
    "id" TEXT NOT NULL,
    "events" TEXT[],
    "ip" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "User_activity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Support_message" (
    "id" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "note" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "support_topicId" TEXT NOT NULL,

    CONSTRAINT "Support_message_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Support_topic" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "author" TEXT NOT NULL,

    CONSTRAINT "Support_topic_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Company_email_key" ON "Company"("email");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User_activity" ADD CONSTRAINT "User_activity_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Support_message" ADD CONSTRAINT "Support_message_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Support_message" ADD CONSTRAINT "Support_message_support_topicId_fkey" FOREIGN KEY ("support_topicId") REFERENCES "Support_topic"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Support_topic" ADD CONSTRAINT "Support_topic_author_fkey" FOREIGN KEY ("author") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
